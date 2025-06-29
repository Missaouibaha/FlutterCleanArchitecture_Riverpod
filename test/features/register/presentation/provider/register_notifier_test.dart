import 'package:clean_arch_riverpod/core/networking/api_error_handler.dart';
import 'package:clean_arch_riverpod/core/networking/api_error_model.dart';
import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/featues/register/data/data_source/remote/models/register_response.dart';
import 'package:clean_arch_riverpod/featues/register/domain/providers/register_domain_providers.dart';
import 'package:clean_arch_riverpod/featues/register/presentation/providers/register_notifier.dart';
import 'package:clean_arch_riverpod/featues/signin/domain/entities/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helper/test_utils.dart';

void main() {
  late MockRegisterUseCase mockUseCase;
  late ProviderContainer providerContainer;

  setUp(() {
    mockUseCase = MockRegisterUseCase();
    providerContainer = ProviderContainer(
      overrides: [
        registerUseCasesProvider.overrideWith((ref) async => mockUseCase),
      ],
    );
    addTearDown(() => providerContainer.dispose());
  });

  test("Should user registration success and retunr user", () async {
    final fakeUser = User(name: "name", token: "token");
    when(
      () => mockUseCase.call(any(), any(), any(), any(), any()),
    ).thenAnswer((_) async => ApiResult.success(fakeUser));

    // act
    // Ensure build finishes — resolves the future

    await providerContainer.read(registerNotifierProvider.future);
    final notifier = providerContainer.read(registerNotifierProvider.notifier);
    await notifier.register("name", "email", "5555", 1, "password");

    final state = providerContainer.read(registerNotifierProvider);

    expect(state, AsyncData<User?>(fakeUser));
  });

  test(" Should user registration fail and return ErrorHandler", () async {
    final failRegisterResponse = RegisterResponse(
      "user already exists",
      false,
      401,
      null,
    );
    //arrange
    when(() => mockUseCase.call(any(), any(), any(), any(), any())).thenAnswer(
      (_) async => ApiResult.failure(
        ErrorHandler(
          apiErrorModel: ApiErrorModel(
            message: failRegisterResponse.message,
            code: failRegisterResponse.code,
          ),
        ),
      ),
    );

    // act

    await providerContainer.read(registerNotifierProvider.future);
    final notifier = providerContainer.read(registerNotifierProvider.notifier);
    await notifier.register("name", "email", "5552222", 1, "password");
    final state = providerContainer.read(registerNotifierProvider);

    expect(state, isA<AsyncError<User?>>());
    expect(state.error.toString(), failRegisterResponse.message);
  });
}
