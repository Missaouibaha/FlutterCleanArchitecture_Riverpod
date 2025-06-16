import 'package:clean_arch_riverpod/core/base/base_remote_data_source.dart';
import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/featues/register/data/data_source/remote/models/register_request_body.dart';
import 'package:clean_arch_riverpod/featues/register/data/data_source/remote/models/register_response.dart';
import 'package:clean_arch_riverpod/featues/register/data/data_source/remote/register_remote_data_source.dart';

class RegisterRemoteDataSourceImpl extends BaseRemoteDataSource
    implements RegisterRemoteDataSource {
  RegisterRemoteDataSourceImpl({super.apiService});

  @override
  Future<ApiResult<RegisterResponse?>> register(
    RegisterRequestBody registerRequestBody,
  ) {
    return safeApiCall(() async {
      return await apiService?.register(registerRequestBody);
    });
  }
}
