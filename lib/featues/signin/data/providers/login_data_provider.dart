import 'package:clean_arch_riverpod/core/base/base_providers.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/local/login_local_data_source.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/local/login_local_data_source_impl.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/remote/login_remote_data_source.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/remote/login_remote_data_source_impl.dart';
import 'package:clean_arch_riverpod/featues/signin/data/repository/login_repository_implementation.dart';
import 'package:clean_arch_riverpod/featues/signin/domain/repository/login_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginLocalDataSourceProvider = FutureProvider<LoginLocalDataSource>((
  ref,
) async {
  final prefs = await ref.read(sharedPrefHelperProvider.future);
  final hiveService = await ref.read(hiveServiceProvider.future);
  return LoginLocalDataSourceImpl(prefs: prefs, hive: hiveService);
});

final loginRemoteDataSourceProvider = FutureProvider<LoginRemoteDataSource>((
  ref,
) async {
  final apiService = await ref.read(apiServiceProvider.future);
  return LoginRemoteDataSourceImpl(apiService: apiService);
});

final loginRepositoryProvider = FutureProvider<LoginRepository>((ref) async {
  final localDataSource = await ref.read(loginLocalDataSourceProvider.future);
  final remoteDataSource = await ref.read(loginRemoteDataSourceProvider.future);

  return LoginRepositoryImplementation(localDataSource, remoteDataSource);
});
