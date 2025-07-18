import 'package:clean_arch_riverpod/core/base/base_providers.dart';
import 'package:clean_arch_riverpod/featues/search/data/data_sources/local/search_local_data_source.dart';
import 'package:clean_arch_riverpod/featues/search/data/data_sources/local/search_local_data_source_impl.dart';
import 'package:clean_arch_riverpod/featues/search/data/data_sources/remote/search_remote_data_sources.dart';
import 'package:clean_arch_riverpod/featues/search/data/data_sources/remote/search_remote_data_sources_impl.dart';
import 'package:clean_arch_riverpod/featues/search/data/repository/search_repository.dart';
import 'package:clean_arch_riverpod/featues/search/domain/repository/doctors_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchLocalDataSourceProvider = FutureProvider<SearchLocalDataSource>((
  ref,
) async {
  final prefs = await ref.read(sharedPrefHelperProvider.future);
  final hive = await ref.read(hiveServiceProvider.future);
  return SearchLocalDataSourceImpl(prefs: prefs, hive: hive);
});

final searchRemoteDataSourceProvider = FutureProvider<SearchRemoteDataSources>((
  ref,
) async {
  final apiService = await ref.read(apiServiceProvider.future);
  return SearchRemoteDataSourcesImpl(apiService: apiService);
});

final searchRepositoryProvider = FutureProvider<SearchRepository>((ref) async {
  final remote = await ref.read(searchRemoteDataSourceProvider.future);
  final local = await ref.read(searchLocalDataSourceProvider.future);
  return SearchRepositoryImpl(remote, local);
});
