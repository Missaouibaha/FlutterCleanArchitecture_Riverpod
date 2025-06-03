import 'package:clean_arch_riverpod/core/base/base_local_data_source.dart';
import 'package:clean_arch_riverpod/core/helper/local/shared_preferences_helper.dart';
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

final baseLocalDataSourceProvider = FutureProvider<BaseLocalDataSource>((
  ref,
) async {
  final sharedPrfHelper = await ref.read(sharedPrefHelperProvider.future);
  return BaseLocalDataSource(sharedPrfHelper);
});
