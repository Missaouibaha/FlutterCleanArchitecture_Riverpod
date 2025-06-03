import 'package:clean_arch_riverpod/core/helper/failure_model.dart';
import 'package:clean_arch_riverpod/featues/splash/data/data_sources/local/splash_local_data_source.dart';
import 'package:clean_arch_riverpod/featues/splash/domain/repository/splash_repository.dart';
import 'package:dartz/dartz.dart';

class SplashRepositoryImplementation implements SplashRepository {
  final SplashLocalDataSource _splashLocalDataSource;
  SplashRepositoryImplementation(this._splashLocalDataSource);

  @override
  Future<Either<Failure, bool>> isAuthenticated() async {
    return await _splashLocalDataSource.isConnected();
  }
}
