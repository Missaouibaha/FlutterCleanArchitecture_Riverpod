import 'package:clean_arch_riverpod/core/networking/api_error_handler.dart';
import 'package:clean_arch_riverpod/core/networking/api_error_model.dart';
import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/remote/models/login_response.dart';
import 'package:clean_arch_riverpod/featues/signin/domain/entities/user.dart';
import 'package:clean_arch_riverpod/featues/signin/domain/providers/login_use_case_provider.dart';
import 'package:clean_arch_riverpod/featues/signin/presentation/providers/login_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helper/test_utils.dart';

void main() {
  late MockLoginUseCase mockUseCase;
  late ProviderContainer providerContainer;
  final User user = User(name: "name", token: "token");
  setUp(() {
    mockUseCase = MockLoginUseCase();
    providerContainer = ProviderContainer(
      overrides: [
        loginUseCaseProvider.overrideWith((ref) async => mockUseCase),
      ],
    );

    addTearDown(() => providerContainer.dispose());
  });

  test("should user loggedIn  and return a user object...", () async {
    when(
      () => mockUseCase.call("email", "password"),
    ).thenAnswer((_) async => ApiResult.success(user));

    // Ensure build finishes — resolves the future
    await providerContainer.read(loginNotifierProvider.future);

    final notifier = providerContainer.read(loginNotifierProvider.notifier);
    await notifier.login("email", "password");

    final state = providerContainer.read(loginNotifierProvider);
    expect(state, AsyncData<User?>(user));
  });

  test("Login must fail if credentials are incorrect", () async {
    final failLoginResponse = LoginResponse(
      message: "Credentials doesn`t match our records",
      userData: null,
      status: false,
      code: 401,
    );
    when(() => mockUseCase.call("email", "password")).thenAnswer(
      (_) async => ApiResult.failure(
        ErrorHandler(
          apiErrorModel: ApiErrorModel(
            message: failLoginResponse.message,
            code: failLoginResponse.code,
          ),
        ),
      ),
    );

    await providerContainer.read(loginNotifierProvider.future);
    final notifier = providerContainer.read(loginNotifierProvider.notifier);
    await notifier.login("email", "password");
    final state = providerContainer.read(loginNotifierProvider);

    expect((state as AsyncError).error, failLoginResponse.message);
  });
}
