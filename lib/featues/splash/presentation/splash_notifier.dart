import 'dart:async';

import 'package:clean_arch_riverpod/core/utils/app_consts.dart';
import 'package:clean_arch_riverpod/featues/splash/domain/splash_usecase_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashNotifier extends AsyncNotifier<bool> {
  @override
  FutureOr<bool> build() async {
    final useCase = await ref.watch(splashUseCaseProvider.future);
    final result = await useCase.call();
    await Future.delayed(Duration(seconds: AppConsts.splashDelay));
    return result.fold((failure) => false, (value) => value);
  }
}

final splashNotifierProvider = AsyncNotifierProvider<SplashNotifier, bool>(
  () => SplashNotifier(),
);
