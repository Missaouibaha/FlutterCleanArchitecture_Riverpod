import 'package:clean_arch_riverpod/featues/signin/data/data_sources/local/models/user_local.dart';

abstract class LoginLocalDataSource {
  Future<void> cacheUser(UserLocal user);
}
