import 'package:clean_arch_riverpod/core/base/base_local_data_source.dart';
import 'package:clean_arch_riverpod/core/services/hive_keys.dart';
import 'package:clean_arch_riverpod/featues/register/data/data_source/local/register_local_datasource.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/local/models/user_local.dart';

class RegisterLocalDatasourceImpl extends BaseLocalDataSource
    implements RegisterLocalDatasource {
  RegisterLocalDatasourceImpl({super.hive, super.prefs});

  @override
  Future<void> cacheUser(UserLocal user) async {
    if (user.token != null) {
      await cacheUserToken(user.token!);
      await cache<UserLocal?>(HiveKeys.connectedUserBox, HiveKeys.user, user);
    }

    await getCached<UserLocal>(HiveKeys.connectedUserBox, HiveKeys.user);
  }
}
