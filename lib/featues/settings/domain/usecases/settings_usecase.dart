import 'package:clean_arch_riverpod/featues/settings/domain/repository/settings_repository.dart';

class SettingsUsecase {
  final SettingsRepository _settingsRepository;
  SettingsUsecase(this._settingsRepository);

  Future<void> call() async {
    await _settingsRepository.logout();
  }
}
