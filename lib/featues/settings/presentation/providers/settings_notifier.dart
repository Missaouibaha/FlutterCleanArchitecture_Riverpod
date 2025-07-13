import 'dart:async';

import 'package:clean_arch_riverpod/featues/settings/domain/providers/settings_domain_providers.dart';
import 'package:clean_arch_riverpod/featues/settings/domain/usecases/settings_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsNotifier extends AsyncNotifier<bool> {
  late final SettingsUsecase _usecase;
  @override
  FutureOr<bool> build() async {
    _usecase = await ref.read(settingUseCaseProvider.future);
    return false;
  }

  Future<void> logout() async {
    state = AsyncValue.loading();
    try {
      await _usecase.call();
      state = AsyncValue.data(true);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final logoutNotifierProvider = AsyncNotifierProvider<SettingsNotifier, bool>(
  () {
    return SettingsNotifier();
  },
);
