import 'package:clean_arch_riverpod/core/base/base_providers.dart';
import 'package:clean_arch_riverpod/featues/settings/data/datasources/local/settings_local_datasources.dart';
import 'package:clean_arch_riverpod/featues/settings/data/datasources/local/settings_local_datasources_impl.dart';
import 'package:clean_arch_riverpod/featues/settings/data/datasources/remote/settings_remote_datasources.dart';
import 'package:clean_arch_riverpod/featues/settings/data/datasources/remote/settings_remote_datasources_impl.dart';
import 'package:clean_arch_riverpod/featues/settings/data/repository/settings_repository_impl.dart';
import 'package:clean_arch_riverpod/featues/settings/domain/repository/settings_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingLocalDataProvider = FutureProvider<SettingsLocalDatasources>((
  ref,
) async {
  final prefs = await ref.read(sharedPrefHelperProvider.future);
  final hive = await ref.read(hiveServiceProvider.future);
  return SettingsLocalDatasourcesImpl(hive: hive, prefs: prefs);
});

final settingRemoteDataProvider = FutureProvider<SettingsRemoteDatasources>((
  ref,
) async {
  final apiService = await ref.read(apiServiceProvider.future);
  return SettingsRemoteDatasourcesImpl(apiService: apiService);
});

final settingRepositoryProvider = FutureProvider<SettingsRepository>((
  ref,
) async {
  final local = await ref.read(settingLocalDataProvider.future);
  final remote = await ref.read(settingRemoteDataProvider.future);
  return SettingsRepositoryImpl(local, remote);
});
