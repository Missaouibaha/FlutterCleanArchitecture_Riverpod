import 'package:clean_arch_riverpod/core/helper/failure_model.dart';
import 'package:clean_arch_riverpod/featues/splash/domain/repository/splash_repository.dart';
import 'package:dartz/dartz.dart';

class CheckUserConnectionUseCase {
  final SplashRepository _splashRepository;

  CheckUserConnectionUseCase(this._splashRepository);

  Future<Either<Failure, bool>> call() async {
    return await _splashRepository.isAuthenticated();
  }
}
