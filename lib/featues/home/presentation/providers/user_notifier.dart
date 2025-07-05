import 'dart:async';

import 'package:clean_arch_riverpod/featues/home/domain/providers/home_domain_providers.dart';
import 'package:clean_arch_riverpod/featues/home/domain/use_cases/user_data_use_case.dart';
import 'package:clean_arch_riverpod/featues/signin/domain/entities/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNotifier extends AsyncNotifier<User?> {
  late UserDataUseCase _userUseCase;

  @override
  FutureOr<User?> build() async {
    _userUseCase = await ref.read(userUseCasesProvider.future);
    final user = await _userUseCase.call();
    return user;
  }
}

final userNotifierProvider = AsyncNotifierProvider<UserNotifier, User?>(
  () => UserNotifier(),
);
