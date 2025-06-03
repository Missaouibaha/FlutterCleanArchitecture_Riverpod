import 'package:clean_arch_riverpod/core/helper/failure_model.dart';
import 'package:dartz/dartz.dart';

abstract class SplashLocalDataSource {
  Future<Either<Failure, bool>> isConnected();
}
