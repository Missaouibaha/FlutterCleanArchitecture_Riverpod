import 'package:clean_arch_riverpod/core/base/base_local_data_source.dart';
import 'package:clean_arch_riverpod/core/helper/extensions.dart';
import 'package:clean_arch_riverpod/core/helper/failure_model.dart';
import 'package:clean_arch_riverpod/core/helper/local/shared_preferences_keys.dart';
import 'package:clean_arch_riverpod/featues/splash/data/data_sources/local/splash_local_data_source.dart';
import 'package:dartz/dartz.dart';

class SplashLocalDataSourceImpl extends BaseLocalDataSource
    implements SplashLocalDataSource {
  SplashLocalDataSourceImpl(super.prefs);

  @override
  Future<Either<Failure, bool>> isConnected() async {
    try {
      final isLoggedIn =
          await prefs?.getValue(SharedPreferencesKeys.isConnected, false) ??
          false;
      final token = await prefs?.getSecureString(SharedPreferencesKeys.token);
      return Right(isLoggedIn && !token.isNullOrEmpty);
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }
}
