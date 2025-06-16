import 'package:clean_arch_riverpod/core/base/base_providers.dart';
import 'package:clean_arch_riverpod/featues/register/data/data_source/local/register_local_datasource.dart';
import 'package:clean_arch_riverpod/featues/register/data/data_source/local/register_local_datasource_impl.dart';
import 'package:clean_arch_riverpod/featues/register/data/data_source/remote/register_remote_data_source.dart';
import 'package:clean_arch_riverpod/featues/register/data/data_source/remote/register_remote_data_source_impl.dart';
import 'package:clean_arch_riverpod/featues/register/data/repository/register_repository_implementation.dart';
import 'package:clean_arch_riverpod/featues/register/domain/repository/register_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerLocalDataProvider = FutureProvider<RegisterLocalDatasource>((
  ref,
) async {
  final prefs = await ref.read(sharedPrefHelperProvider.future);
  final hiveService = await ref.read(hiveServiceProvider.future);

  return RegisterLocalDatasourceImpl(prefs: prefs, hive: hiveService);
});

final registerRemoteDataProvider = FutureProvider<RegisterRemoteDataSource>((
  ref,
) async {
  final apiService = await ref.read(apiServiceProvider.future);

  return RegisterRemoteDataSourceImpl(apiService: apiService);
});

final registerRepositoryProvider = FutureProvider<RegisterRepository>((
  ref,
) async {
  final remoteDataSource = await ref.read(registerRemoteDataProvider.future);
  final localDataSource = await ref.read(registerLocalDataProvider.future);

  return RegisterRepositoryImplementation(localDataSource, remoteDataSource);
});
