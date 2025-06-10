import 'dart:async';

import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:clean_arch_riverpod/featues/signin/domain/entities/user.dart';
import 'package:clean_arch_riverpod/featues/signin/domain/providers/login_use_case_provider.dart';
import 'package:clean_arch_riverpod/featues/signin/domain/usecases/login_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginNotifier extends AsyncNotifier<User?> {
  late final LoginUseCase _loginUseCase;

  @override
  FutureOr<User?> build() async {
    _loginUseCase = await ref.read(loginUseCaseProvider.future);
    return null;
  }

  Future<void> login(String email, String password) async {
    state = AsyncValue.loading();

    final result = await _loginUseCase.call(email, password);
    result.when(
      success: (user) {
        state = AsyncValue.data(user);
      },
      failure: (errorHandler) {
        state = AsyncValue.error(
          errorHandler.apiErrorModel.message ?? AppStrings.unknownError,
          StackTrace.current,
        );
      },
    );
  }
}

final loginNotifierProvider = AsyncNotifierProvider<LoginNotifier, User?>(() {
  return LoginNotifier();
});
