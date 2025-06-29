import 'package:clean_arch_riverpod/clean_arch_app.dart';
import 'package:clean_arch_riverpod/core/helper/routing/app_router.dart';
import 'package:clean_arch_riverpod/core/helper/routing/routes.dart';
import 'package:clean_arch_riverpod/core/networking/api_error_handler.dart';
import 'package:clean_arch_riverpod/core/networking/api_error_model.dart';
import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:clean_arch_riverpod/core/widgets/app_text_button.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/remote/models/login_response.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/remote/models/user_data.dart';
import 'package:clean_arch_riverpod/featues/signin/data/providers/login_data_provider.dart';
import 'package:clean_arch_riverpod/featues/signin/data/repository/login_repository_implementation.dart';
import 'package:clean_arch_riverpod/featues/signin/domain/entities/user.dart'
    show User;
import 'package:clean_arch_riverpod/featues/signin/domain/providers/login_use_case_provider.dart';
import 'package:clean_arch_riverpod/featues/signin/presentation/providers/login_notifier.dart';
import 'package:clean_arch_riverpod/featues/signin/presentation/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helper/test_utils.dart';

void main() {
  late MockNavigatorObservor mockNavigator;
  late MockLoginRemoteDataSource mockRemoteDatasource;
  late MockLoginLocalDataSource mockLocalDatasource;
  late MockLoginUseCase mockUseCase;
  late GoRouter testRouter;
  final fakeLoginResponse = LoginResponse(
    code: 1,
    message: "fake Login Response",
    status: true,
    userData: UserData(name: "name", token: "token"),
  );
  setUpAll(() {
    registerFallbackValue(FakeRoute());
  });
  setUp(() {
    mockRemoteDatasource = MockLoginRemoteDataSource();
    mockLocalDatasource = MockLoginLocalDataSource();
    mockNavigator = MockNavigatorObservor();
    mockUseCase = MockLoginUseCase();

    testRouter = GoRouter(
      initialLocation: Routes.loginScreen,

      routes: [
        GoRoute(
          name: Routes.loginScreen,
          path: Routes.loginScreen,
          builder: (context, state) => const SignInScreen(),
        ),
        GoRoute(
          name: Routes.mainScreen,
          path: Routes.mainScreen,
          builder: (context, state) => const Scaffold(body: Text('Main')),
        ),
      ],

      observers: [mockNavigator],
    );
  });

  Future<void> _pumpLoginScreen(
    WidgetTester tester,
    ProviderContainer container,
  ) async {
    await tester.pumpWidget(
      UncontrolledProviderScope(container: container, child: CleanArchApp()),
    );
    await tester.pumpAndSettle();
  }

  Future<void> _fillForm(WidgetTester widgetTester) async {
    //fill text fields
    await widgetTester.enterText(find.byType(TextField).first, 'email@gsg.cc');
    await widgetTester.enterText(find.byType(TextField).last, 'password');

    //finder login button
    final loginButton = find.widgetWithText(AppTextButton, AppStrings.login);

    // ensure button is visible
    await widgetTester.ensureVisible(loginButton);

    // tap login button
    await widgetTester.tap(loginButton);

    //start rebuild after the state changed
    await widgetTester.pump();

  }

  testWidgets("should user loggedIn  and return a user object..", (
    widgetTester,
  ) async {
    final user = User(token: "token", name: "name");
    final container = ProviderContainer(
      overrides: [
        loginUseCaseProvider.overrideWith((_) => Future.value(mockUseCase)),
        loginRemoteDataSourceProvider.overrideWith(
          (ref) => Future.value(mockRemoteDatasource),
        ),
        loginLocalDataSourceProvider.overrideWith(
          (ref) => Future.value(mockLocalDatasource),
        ),
        loginRepositoryProvider.overrideWith(
          (ref) => LoginRepositoryImplementation(
            mockLocalDatasource,
            mockRemoteDatasource,
          ),
        ),

        routerProvider.overrideWith((ref) => testRouter),
      ],
    );
    //arrange

    when(
      () => mockRemoteDatasource.login("email@gsg.cc", "password"),
    ).thenAnswer((_) async {
      return ApiResult.success(fakeLoginResponse);
    });

    when(
      () => mockUseCase.call("email@gsg.cc", "password"),
    ).thenAnswer((_) async => ApiResult.success(user));
    // act
    await _pumpLoginScreen(widgetTester, container);

    await _fillForm(widgetTester);

    // Wait for the loading to process
    await widgetTester.runAsync(() async {
      await Future.delayed(const Duration(seconds: 5));
    });

    final state = container.read(loginNotifierProvider);
    //assert

    verify(() => mockUseCase.call('email@gsg.cc', 'password')).called(1);
    expect(state, isA<AsyncData<User?>>());
    state.when(
      data: (data) {
        expect("${data?.name}", user.name);
      },
      error: (error, stackTrace) {},
      loading: () {},
    );
    verify(() => mockNavigator.didPush(any(), any())).called(greaterThan(0));
    expect(find.text("Main"), findsOneWidget);
  });

  testWidgets("Login must fail if credentials are incorrect", (
    widgetTester,
  ) async {
    final mockLoginUseCase = MockLoginUseCase();
    final errorHandler = ErrorHandler(
      apiErrorModel: ApiErrorModel(
        message: "Credentials doesn`t match our records",
        code: 55,
      ),
    );
    final container = ProviderContainer(
      overrides: [
        loginUseCaseProvider.overrideWith(
          (ref) => Future.value(mockLoginUseCase),
        ),
        loginLocalDataSourceProvider.overrideWith((ref) => mockLocalDatasource),
        loginRemoteDataSourceProvider.overrideWith(
          (ref) => mockRemoteDatasource,
        ),
        loginRepositoryProvider.overrideWith(
          (ref) => LoginRepositoryImplementation(
            mockLocalDatasource,
            mockRemoteDatasource,
          ),
        ),
        routerProvider.overrideWith((ref) => testRouter),
      ],
    );
    // arrange
    when(
      () => mockLoginUseCase.call(any(), any()),
    ).thenAnswer((_) async => ApiResult.failure(errorHandler));

    // unecessary call
    when(
      () => mockRemoteDatasource.login(any(), any()),
    ).thenAnswer((_) async => ApiResult.failure(errorHandler));

    // act
    await _pumpLoginScreen(widgetTester, container);

    await _fillForm(widgetTester);


    final state = container.read(loginNotifierProvider);
    verify(() => mockLoginUseCase.call("email@gsg.cc", "password")).called(1);

    expect(state, isA<AsyncError>());

    state.when(
      data: (data) {
        fail("Test failed: expected failure, but got success.");
      },
      error: (error, stackTrace) async {
        expect(error.toString(), errorHandler.apiErrorModel.message);
        expect(find.byKey(Key("error_dialog")), findsOneWidget);
        await widgetTester.tap(find.text(AppStrings.ok));
        await widgetTester.pumpAndSettle();
        expect(find.byKey(Key("error_dialog")), findsNothing);
      },
      loading: () {
        fail("Test failed: expected failure, but got loading.");
      },
    );
  });
}
