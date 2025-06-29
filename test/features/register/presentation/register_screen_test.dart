import 'package:clean_arch_riverpod/clean_arch_app.dart';
import 'package:clean_arch_riverpod/core/helper/routing/app_router.dart';
import 'package:clean_arch_riverpod/core/helper/routing/routes.dart';
import 'package:clean_arch_riverpod/core/networking/api_error_handler.dart';
import 'package:clean_arch_riverpod/core/networking/api_error_model.dart';
import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:clean_arch_riverpod/featues/register/data/data_source/remote/models/register_request_body.dart';
import 'package:clean_arch_riverpod/featues/register/data/data_source/remote/models/register_response.dart';
import 'package:clean_arch_riverpod/featues/register/data/providers/register_data_providers.dart';
import 'package:clean_arch_riverpod/featues/register/data/repository/register_repository_implementation.dart';
import 'package:clean_arch_riverpod/featues/register/domain/providers/register_domain_providers.dart';
import 'package:clean_arch_riverpod/featues/register/presentation/providers/register_notifier.dart';
import 'package:clean_arch_riverpod/featues/register/presentation/register_screen.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/remote/models/user_data.dart';
import 'package:clean_arch_riverpod/featues/signin/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helper/test_utils.dart';

void main() {
  late MockRegisterRemote mockRemote;
  late MockRegisterLocalDataSource mockLocal;
  late MockNavigatorObservor mockNavigator;
  late MockRegisterUseCase mockUseCase;
  late GoRouter testRouter;

  setUpAll(() {
    registerFallbackValue(
      RegisterRequestBody(
        "name",
        "email",
        "22222222",
        "password",
        "password",
        1,
      ),
    );
    registerFallbackValue(FakeRoute());
  });

  setUp(() {
    mockRemote = MockRegisterRemote();
    mockLocal = MockRegisterLocalDataSource();
    mockNavigator = MockNavigatorObservor();
    mockUseCase = MockRegisterUseCase();

    testRouter = GoRouter(
      initialLocation: Routes.registerScreen,
      routes: [
        GoRoute(
          path: Routes.registerScreen,
          name: Routes.registerScreen,
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: Routes.mainScreen,
          name: Routes.mainScreen,
          builder: (context, state) => const Scaffold(body: Text('Main')),
        ),
      ],
      observers: [mockNavigator],
    );
  });

  Future<void> _pumpScreen(
    WidgetTester tester,
    ProviderContainer container,
  ) async {
    await tester.pumpWidget(
      UncontrolledProviderScope(container: container, child: CleanArchApp()),
    );
    // Wait for async build of notifier
    await tester.pumpAndSettle();
  }

  Future<void> _fillForm(WidgetTester tester) async {
    await tester.enterText(find.byKey(const Key('nameField')), 'bobo');
    await tester.enterText(
      find.byKey(const Key('emailField')),
      'email@aaa.fff',
    );
    await tester.enterText(find.byKey(const Key('phoneField')), '22222222');
    await tester.enterText(find.byKey(const Key('passwordField')), 'password');
    await tester.enterText(
      find.byKey(const Key('confirmPasswordField')),
      'password',
    );
    // Scroll/ensure checkbox visible and tap it
    await tester.ensureVisible(find.byKey(const Key('femaleCheckbox')));
    await tester.tap(find.byKey(const Key('femaleCheckbox')));
    await tester.pumpAndSettle();
    // Ensure register button visible and tap it

    await tester.ensureVisible(find.byKey(const Key('register_button')));
    await tester.tap(find.byKey(const Key('register_button')));
    await tester.pump();
  }

  testWidgets("Should user registration success and navigate to main screen", (
    tester,
  ) async {
    final registerResponse = RegisterResponse(
      "message",
      true,
      200,
      UserData(name: "name", token: "token"),
    );

    when(
      () => mockRemote.register(any()),
    ).thenAnswer((_) async => ApiResult.success(registerResponse));

    when(() => mockUseCase.call(any(), any(), any(), any(), any())).thenAnswer(
      (_) async => ApiResult.success(User(token: "token", name: "bobo")),
    );

    final container = ProviderContainer(
      overrides: [
        registerUseCasesProvider.overrideWith(
          (ref) => Future.value(mockUseCase),
        ),
        registerRemoteDataProvider.overrideWith(
          (_) => Future.value(mockRemote),
        ),
        registerLocalDataProvider.overrideWith((_) => Future.value(mockLocal)),
        registerRepositoryProvider.overrideWith(
          (ref) => RegisterRepositoryImplementation(mockLocal, mockRemote),
        ),
        routerProvider.overrideWithValue(testRouter),
      ],
    );

    await _pumpScreen(tester, container);

    _fillForm(tester);

    // Wait until state is AsyncData<User?>
    await tester.runAsync(() async {
      while (container.read(registerNotifierProvider) is! AsyncData<User?>) {
        await Future.delayed(const Duration(milliseconds: 50));
      }
    });

    final state = container.read(registerNotifierProvider);

    verify(
      () =>
          mockUseCase.call('bobo', 'email@aaa.fff', '22222222', 1, 'password'),
    ).called(1);

    state.when(
      data: (user) {
        expect(user?.name, equals('bobo'));
      },
      loading: () {
        fail('Still loading');
      },
      error: (error, _) {
        fail('Unexpected error: $error');
      },
    );

    verify(() => mockNavigator.didPush(any(), any())).called(greaterThan(0));

    expect(find.text('Main'), findsOneWidget);
    // or
    final text = tester.widget<Text>(find.byType(Text));
    expect(text.data, 'Main');
  });

  testWidgets(
    "Should user registration  fail with error eg : user already exists",
    (widgetTester) async {
      final failResponse = RegisterResponse(
        "User already exists",
        false,
        401,
        null,
      );
      final errorHandler = ErrorHandler(
        apiErrorModel: ApiErrorModel(
          message: failResponse.message,
          code: failResponse.code,
        ),
      );

      when(
        () => mockRemote.register(any()),
      ).thenAnswer((_) async => ApiResult.success(failResponse));

      when(
        () => mockUseCase.call(any(), any(), any(), any(), any()),
      ).thenAnswer((_) async => ApiResult.failure(errorHandler));

      final container = ProviderContainer(
        overrides: [
          registerUseCasesProvider.overrideWith((ref) => mockUseCase),
          registerLocalDataProvider.overrideWith((ref) => mockLocal),
          registerRemoteDataProvider.overrideWith((ref) => mockRemote),
          registerRepositoryProvider.overrideWith(
            (ref) => RegisterRepositoryImplementation(mockLocal, mockRemote),
          ),
          routerProvider.overrideWith((ref) => testRouter),
        ],
      );
      await _pumpScreen(widgetTester, container);

      _fillForm(widgetTester);

      // Wait until state is AsyncData<User?>
      await widgetTester.runAsync(() async {
        await Future.delayed(const Duration(seconds: 3));
      });

      final state = container.read(registerNotifierProvider);

      verify(
        () => mockUseCase.call(
          'bobo',
          'email@aaa.fff',
          '22222222',
          1,
          'password',
        ),
      ).called(1);

      state.when(
        data: (user) {
          fail("expect fail but got success");
        },
        loading: () {
          fail('Still loading');
        },
        error: (error, _) async {
          expect(error.toString(), errorHandler.apiErrorModel.message);
          expect(find.byKey(Key("error_dialog")), findsOneWidget);
          expect(find.text(error.toString()), findsOneWidget);

          await widgetTester.tap(find.text(AppStrings.ok));
          await widgetTester.pumpAndSettle();
          // Dialog should be gone
          expect(find.byKey(const Key('error_dialog')), findsNothing);
        },
      );
    },
  );
}
