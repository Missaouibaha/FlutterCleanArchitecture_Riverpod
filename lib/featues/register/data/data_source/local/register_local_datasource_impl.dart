import 'package:clean_arch_riverpod/core/base/base_local_data_source.dart';
import 'package:clean_arch_riverpod/core/helper/extensions.dart';
import 'package:clean_arch_riverpod/core/services/hive_keys.dart';
import 'package:clean_arch_riverpod/featues/register/data/data_source/local/register_local_datasource.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/local/models/user_local.dart';

class RegisterLocalDatasourceImpl extends BaseLocalDataSource
    implements RegisterLocalDatasource {
  RegisterLocalDatasourceImpl({super.hive, super.prefs});

  @override
  Future<void> cacheUser(UserLocal user) async {
    await user.token?.let((it) => cacheToken(it));
    cache(HiveKeys.connectedUserBox, HiveKeys.user, user);
  }

  Future<void> cacheToken(String token) async {
    await cacheUserToken(token);
  }
}
