import 'package:clean_arch_riverpod/core/networking/api_error_handler.dart';
import 'package:clean_arch_riverpod/core/networking/api_error_model.dart';
import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/featues/register/data/data_source/remote/models/register_request_body.dart';
import 'package:clean_arch_riverpod/featues/register/data/data_source/remote/models/register_response.dart';
import 'package:clean_arch_riverpod/featues/register/data/providers/register_data_providers.dart';
import 'package:clean_arch_riverpod/featues/register/presentation/providers/register_notifier.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/local/models/user_local.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/remote/models/user_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helper/test_utils.dart';

void main() {
  late MockRegisterLocalDataSource mockRegisterLocalDataSource;
  late MockRegisterRemote mockRegisterRemoteDataSource;
  late ProviderContainer providerContainer;
  final regiseterResponse = RegisterResponse(
    "message",
    true,
    200,
    UserData(name: "name", token: "token"),
  );

  setUp(() {
    mockRegisterRemoteDataSource = MockRegisterRemote();
    mockRegisterLocalDataSource = MockRegisterLocalDataSource();
    providerContainer = ProviderContainer(
      overrides: [
        registerRemoteDataProvider.overrideWith(
          (ref) => mockRegisterRemoteDataSource,
        ),
        registerLocalDataProvider.overrideWith(
          (ref) => mockRegisterLocalDataSource,
        ),
      ],
    );
    addTearDown(() => providerContainer.dispose());
  });
  setUpAll(() {
    registerFallbackValue(UserLocal(name: "name", token: "token"));
    registerFallbackValue(
      RegisterRequestBody("name", "email", "phone", "password", "password", 1),
    );
  });

  test("Should user registration success and return user", () async {
    when(
      () => mockRegisterRemoteDataSource.register(any()),
    ).thenAnswer((_) async => ApiResult.success(regiseterResponse));
    when(
      () => mockRegisterLocalDataSource.cacheUser(any()),
    ).thenAnswer((_) async => {});

    //
    await providerContainer.read(registerNotifierProvider.future);
    final notifier = providerContainer.read(registerNotifierProvider.notifier);
    await notifier.register("name", "email", "5844444", 1, "password");

    final state = providerContainer.read(registerNotifierProvider);

    state.when(
      data: (user) {
        expect(user?.name, regiseterResponse.userData?.name);
      },
      error: (error, stackTrace) {
        fail("Test failed: expected success, but got failure.");
      },
      loading: () {
        fail("Test failed: expected success, but got loading.");
      },
    );

    verify(() => mockRegisterLocalDataSource.cacheUser(any())).called(1);
  });

  test("Should user registration fail  ....", () async {
    final failRegisterResponse = RegisterResponse(
      "user already exists",
      false,
      401,
      null,
    );

    when(() => mockRegisterRemoteDataSource.register(any())).thenAnswer(
      (_) async => ApiResult.failure(
        ErrorHandler(
          apiErrorModel: ApiErrorModel(
            message: failRegisterResponse.message,
            code: failRegisterResponse.code,
          ),
        ),
      ),
    );

    await providerContainer.read(registerNotifierProvider.future);
    final notifier = providerContainer.read(registerNotifierProvider.notifier);
    await notifier.register("name", "email", "5555555", 1, "password");

    final state = providerContainer.read(registerNotifierProvider);

    state.when(
      data: (data) {
        fail("Test failed: expected fail, but got success.");
      },
      error: (error, stackTrace) {
        expect(error.toString(), failRegisterResponse.message);
      },
      loading: () {
        fail("Test failed: expected fail, but got loading ");
      },
    );
  });
}
