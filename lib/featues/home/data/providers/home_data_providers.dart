import 'package:clean_arch_riverpod/core/base/base_providers.dart';
import 'package:clean_arch_riverpod/featues/home/data/data_sources/local/home_local_data_source.dart';
import 'package:clean_arch_riverpod/featues/home/data/data_sources/local/home_local_data_source_impl.dart';
import 'package:clean_arch_riverpod/featues/home/data/data_sources/remote/home_remote_data_source.dart';
import 'package:clean_arch_riverpod/featues/home/data/data_sources/remote/home_remote_data_source_impl.dart';
import 'package:clean_arch_riverpod/featues/home/data/repository/home_repository_impl.dart';
import 'package:clean_arch_riverpod/featues/home/domain/repository/home_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeLocalDataProvider = FutureProvider<HomeLocalDataSource>((ref) async {
  final prefs = await ref.read(sharedPrefHelperProvider.future);
  final hiveService = await ref.read(hiveServiceProvider.future);
  return HomeLocalDataSourceImpl(prefs: prefs, hive: hiveService);
});

final homeRemoteDataProvider = FutureProvider<HomeRemoteDataSource>((
  ref,
) async {
  final apiService = await ref.read(apiServiceProvider.future);
  return HomeRemoteDataSourceImpl(apiService: apiService);
});

final homeRepositoryProvider = FutureProvider<HomeRepository>((ref) async {
  final homeLocalData = await ref.read(homeLocalDataProvider.future);
  final homeRemoteData = await ref.read(homeRemoteDataProvider.future);

  return HomeRepositoryImpl(homeLocalData, homeRemoteData);
});
