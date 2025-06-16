import 'package:clean_arch_riverpod/core/networking/api_constants.dart';
import 'package:clean_arch_riverpod/core/networking/api_error_handler.dart';
import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/featues/register/data/data_source/local/register_local_datasource.dart';
import 'package:clean_arch_riverpod/featues/register/data/data_source/remote/models/register_request_body.dart';
import 'package:clean_arch_riverpod/featues/register/data/data_source/remote/register_remote_data_source.dart';
import 'package:clean_arch_riverpod/featues/register/domain/repository/register_repository.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/mappers/user_data_mapper.dart';
import 'package:clean_arch_riverpod/featues/signin/domain/entities/user.dart';

class RegisterRepositoryImplementation implements RegisterRepository {
  final RegisterLocalDatasource registerLocalDatasource;
  final RegisterRemoteDataSource registerRemoteDataSource;
  RegisterRepositoryImplementation(
    this.registerLocalDatasource,
    this.registerRemoteDataSource,
  );
  @override
  Future<ApiResult<User>> register(
    String name,
    String email,
    String phone,
    int gender,
    String password,
  ) async {
    try {
      final result = await registerRemoteDataSource.register(
        RegisterRequestBody(name, email, phone, password, password, gender),
      );

      return result.when(
        success: (registerResponse) {
          final user = registerResponse?.userData;

          if (user != null) {
            registerLocalDatasource.cacheUser(user.toLocal());
            return ApiResult.success(user.toDomain());
          } else {
            return ApiResult.failure(ErrorHandler.handle(ApiErrors.noContent));
          }
        },
        failure: (error) {
          return ApiResult.failure(error);
        },
      );
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
