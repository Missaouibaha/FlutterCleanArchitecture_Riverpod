import 'package:clean_arch_riverpod/core/base/base_providers.dart';
import 'package:clean_arch_riverpod/featues/splash/data/data_sources/local/splash_local_data_source.dart';
import 'package:clean_arch_riverpod/featues/splash/data/data_sources/local/splash_local_data_source_impl.dart';
import 'package:clean_arch_riverpod/featues/splash/data/repository/splash_repository_implementation.dart';
import 'package:clean_arch_riverpod/featues/splash/domain/repository/splash_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final splashLocalDataSourceProvider = FutureProvider<SplashLocalDataSource>((
  ref,
) async {
  final prefs = await ref.read(sharedPrefHelperProvider.future);
  
  final hive = await ref.read(hiveServiceProvider.future);
  return SplashLocalDataSourceImpl(prefs: prefs);
});

final splashRepositoryProvider = FutureProvider<SplashRepository>((ref) async {
  final dataSource = await ref.watch(splashLocalDataSourceProvider.future);
  return SplashRepositoryImplementation(dataSource);
});
