import 'package:clean_arch_riverpod/featues/settings/data/datasources/local/settings_local_datasources.dart';
import 'package:clean_arch_riverpod/featues/settings/data/datasources/remote/settings_remote_datasources.dart';
import 'package:clean_arch_riverpod/featues/settings/domain/repository/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDatasources _localDatasources;
  final SettingsRemoteDatasources _remoteDatasources;
  SettingsRepositoryImpl(this._localDatasources, this._remoteDatasources);

  @override
  Future<void> logout() async {
    await _localDatasources.logout();
  }
}
