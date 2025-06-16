import 'package:clean_arch_riverpod/core/base/base_local_data_source.dart';
import 'package:clean_arch_riverpod/core/base/base_remote_data_source.dart';
import 'package:clean_arch_riverpod/core/helper/local/shared_preferences_helper.dart';
import 'package:clean_arch_riverpod/core/networking/api_service.dart';
import 'package:clean_arch_riverpod/core/networking/dio_factory.dart';
import 'package:clean_arch_riverpod/core/services/hive_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((
  ref,
) async {
  return await SharedPreferences.getInstance();
});

final flutterSecureStorageProvider = Provider<FlutterSecureStorage>(
  (ref) => FlutterSecureStorage(),
);

final sharedPrefHelperProvider = FutureProvider<SharedPreferencesHelper>((
  ref,
) async {
  final pref = await ref.read(sharedPreferencesProvider.future);
  final secureStorage = ref.read(flutterSecureStorageProvider);
  return SharedPreferencesHelper(pref, secureStorage);
});

final hiveServiceProvider = FutureProvider<HiveService>((ref) {
  return HiveService();
});

final baseLocalDataSourceProvider = FutureProvider<BaseLocalDataSource>((
  ref,
) async {
  final sharedPrfHelper = await ref.read(sharedPrefHelperProvider.future);
  final hiveService = await ref.read(hiveServiceProvider.future);

  return BaseLocalDataSource(prefs: sharedPrfHelper, hive: hiveService);
});

final dioProvider = FutureProvider<Dio>((ref) {
  return DioFactory.getDio();
});

final apiServiceProvider = FutureProvider<ApiService>((ref) async {
  final dio = await ref.read(dioProvider.future);

  return ApiService(dio);
});

final baseRemoteDataSourceProvider = FutureProvider<BaseRemoteDataSource>((
  ref,
) async {
  final apiService = await ref.read(apiServiceProvider.future);
  return BaseRemoteDataSource(apiService: apiService);
});
