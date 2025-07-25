import 'package:clean_arch_riverpod/core/base/base_local_data_source.dart';
import 'package:clean_arch_riverpod/core/helper/local/shared_preferences_helper.dart';
import 'package:clean_arch_riverpod/core/services/hive_keys.dart';
import 'package:clean_arch_riverpod/core/services/hive_service.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/local/login_local_data_source.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/local/models/user_local.dart';

class LoginLocalDataSourceImpl extends BaseLocalDataSource
    implements LoginLocalDataSource {
  LoginLocalDataSourceImpl({
    required SharedPreferencesHelper prefs,
    required HiveService hive,
  }) : super(prefs: prefs, hive: hive);

  @override
  Future<void> cacheUser(UserLocal user) async {
    if (user.token != null) {
      await cacheUserToken(user.token!);
      await cache<UserLocal?>(HiveKeys.connectedUserBox, HiveKeys.user, user);
    }
  }
}
