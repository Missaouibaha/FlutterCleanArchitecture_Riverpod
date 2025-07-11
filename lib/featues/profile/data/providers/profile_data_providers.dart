import 'package:clean_arch_riverpod/core/base/base_providers.dart';
import 'package:clean_arch_riverpod/featues/profile/data/dataSources/local/profile_local_data_source.dart';
import 'package:clean_arch_riverpod/featues/profile/data/dataSources/local/profile_local_data_source_impl.dart';
import 'package:clean_arch_riverpod/featues/profile/data/dataSources/remote/profile_remote_data_source.dart';
import 'package:clean_arch_riverpod/featues/profile/data/dataSources/remote/profile_remote_data_source_impl.dart';
import 'package:clean_arch_riverpod/featues/profile/data/repository/profile_repository_impl.dart';
import 'package:clean_arch_riverpod/featues/profile/domain/repository/profile_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileLocalDataSource = FutureProvider<ProfileLocalDataSource>((
  ref,
) async {
  final hiveService = await ref.read(hiveServiceProvider.future);
  final prefs = await ref.read(sharedPrefHelperProvider.future);
  return ProfileLocalDataSourceImpl(hive: hiveService, prefs: prefs);
});

final profileRemoteDataSource = FutureProvider<ProfileRemoteDataSource>((
  ref,
) async {
  final apiService = await ref.read(apiServiceProvider.future);
  return ProfileRemoteDataSourceImpl(apiService: apiService);
});

final profileRepositoryProvider = FutureProvider<ProfileRepository>((ref) async {
  final localDataSource = await ref.read(profileLocalDataSource.future);
  final remoteDataSource = await ref.read(profileRemoteDataSource.future);
  return ProfileRepositoryImpl(remoteDataSource, localDataSource);
});
