import 'package:clean_arch_riverpod/core/base/base_local_data_source.dart';
import 'package:clean_arch_riverpod/featues/settings/data/datasources/local/settings_local_datasources.dart';

class SettingsLocalDatasourcesImpl extends BaseLocalDataSource
    implements SettingsLocalDatasources {
  SettingsLocalDatasourcesImpl({super.hive, super.prefs});
  @override
  Future<void> logout() async {
    await logoutAndClearCache();
  }
}
