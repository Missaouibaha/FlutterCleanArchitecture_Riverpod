import 'package:clean_arch_riverpod/core/networking/api_constants.dart';
import 'package:clean_arch_riverpod/core/networking/api_error_handler.dart';
import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/local/login_local_data_source.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/mappers/user_data_mapper.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/remote/login_remote_data_source.dart';
import 'package:clean_arch_riverpod/featues/signin/domain/entities/user.dart';
import 'package:clean_arch_riverpod/featues/signin/domain/repository/login_repository.dart';

class LoginRepositoryImplementation implements LoginRepository {
  final LoginLocalDataSource _loginLocalDataSource;
  final LoginRemoteDataSource _loginRemoteDataSource;
  LoginRepositoryImplementation(
    this._loginLocalDataSource,
    this._loginRemoteDataSource,
  );
  @override
  Future<ApiResult<User>> login(String email, String password) async {
    try {
      final result = await _loginRemoteDataSource.login(email, password);

      return result.when(
        success: (data) async {
          final user = data?.userData;
          if (user != null) {
            await _loginLocalDataSource.cacheUser(user.toLocal());

            return ApiResult.success(user.toDomain());
          } else {
            return ApiResult.failure(ErrorHandler.handle(ApiErrors.noContent));
          }
        },
        failure: (errorHandler) {
          return ApiResult.failure(errorHandler);
        },
      );
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
