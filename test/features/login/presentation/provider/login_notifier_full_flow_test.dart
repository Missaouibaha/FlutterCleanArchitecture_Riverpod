import 'package:clean_arch_riverpod/core/networking/api_error_handler.dart';
import 'package:clean_arch_riverpod/core/networking/api_error_model.dart';
import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/local/models/user_local.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/remote/models/login_response.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/remote/models/user_data.dart';
import 'package:clean_arch_riverpod/featues/signin/data/providers/login_data_provider.dart';
import 'package:clean_arch_riverpod/featues/signin/presentation/providers/login_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helper/test_utils.dart';

void main() {
  late ProviderContainer container;
  late MockLoginRemoteDataSource mockRemote;
  late MockLoginLocalDataSource mockLocal;
  final fakeLoginResponse = LoginResponse(
    code: 1,
    message: "fake Login Response",
    status: true,
    userData: UserData(name: "Fake", token: "fake token"),
  );
  setUp(() {
    mockRemote = MockLoginRemoteDataSource();
    mockLocal = MockLoginLocalDataSource();
    container = ProviderContainer(
      overrides: [
        loginRemoteDataSourceProvider.overrideWith((ref) => mockRemote),
        loginLocalDataSourceProvider.overrideWith((ref) => mockLocal),
      ],
    );
    addTearDown(() => container.dispose());
  });
  setUpAll(() {
    registerFallbackValue(
      UserLocal(
        name: fakeLoginResponse.userData?.name,
        token: fakeLoginResponse.userData?.token,
      ),
    );
  });

  test('should user loggedIn  and return a user object...', () async {
    //arrange
    when(
      () => mockRemote.login("email", "password"),
    ).thenAnswer((_) async => ApiResult.success(fakeLoginResponse));
    when(() => mockLocal.cacheUser(any())).thenAnswer((_) async {});

    await container.read(loginNotifierProvider.future);
    final notifier = container.read(loginNotifierProvider.notifier);
    await notifier.login("email", "password");
    //assert
    verify(() => mockLocal.cacheUser(any())).called(1);
    final state = container.read(loginNotifierProvider);
    state.when(
      data: (user) {
        expect(user?.token, fakeLoginResponse.userData?.token);
        expect(user?.name, fakeLoginResponse.userData?.name);
      },
      error: (error, stackTrace) {
        fail("Test failed: expected success, but got failure.");
      },
      loading: () {
        fail("Test failed: expected success, but got loading.");
      },
    );
  });

  test('Login must fail if credentials are incorrect ', () async {
    final failLoginResponse = LoginResponse(
      message: "Credentials doesn`t match our records",
      userData: null,
      status: false,
      code: 401,
    );
    //arrange
    when(() => mockRemote.login("email", "password")).thenAnswer(
      (_) async => ApiResult.failure(
        ErrorHandler(
          apiErrorModel: ApiErrorModel(message: failLoginResponse.message),
        ),
      ),
    );

    await container.read(loginNotifierProvider.future);
    final notifier = container.read(loginNotifierProvider.notifier);
    await notifier.login("email", "password");
    //assert

    //act
    final state = container.read(loginNotifierProvider);
    state.when(
      data: (user) {
        fail("Test failed: expected failure, but got success.");
      },
      error: (error, stackTrace) {
        expect(error, failLoginResponse.message);
      },
      loading: () {
        fail("Test failed: expected failure, but got loading.");
      },
    );
  });
}
