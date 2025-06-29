import 'dart:async';

import 'package:clean_arch_riverpod/featues/register/domain/providers/register_domain_providers.dart';
import 'package:clean_arch_riverpod/featues/register/domain/usecases/register_usecase.dart';
import 'package:clean_arch_riverpod/featues/signin/domain/entities/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterNotifier extends AsyncNotifier<User?> {
  late RegisterUsecase _registerUseCase;
  @override
  FutureOr<User?> build() async {
    _registerUseCase = await ref.read(registerUseCasesProvider.future);
    return null;
  }

  Future<void> register(
    String name,
    String email,
    String phone,
    int gender,
    String password,
  ) async {
    
    state = AsyncValue.loading();
    final result = await _registerUseCase.call(
      name,
      email,
      phone,
      gender,
      password,
    );
    result.whenOrNull(
      success: (data) {
        state = AsyncValue.data(data);
      },
      failure: (errorHandler) {
        String errorMessage = errorHandler.apiErrorModel.getErrorMessage();

        state = AsyncValue.error(errorMessage, StackTrace.current);
      },
    );
  }
}

final registerNotifierProvider = AsyncNotifierProvider<RegisterNotifier, User?>(
  () => RegisterNotifier(),
);
