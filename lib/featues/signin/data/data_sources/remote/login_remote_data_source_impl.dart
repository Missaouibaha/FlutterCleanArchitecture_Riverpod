import 'package:clean_arch_riverpod/core/base/base_remote_data_source.dart';
import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/core/networking/api_service.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/remote/login_remote_data_source.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/remote/models/login_request_body.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/remote/models/login_response.dart';

class LoginRemoteDataSourceImpl extends BaseRemoteDataSource
    implements LoginRemoteDataSource {
  LoginRemoteDataSourceImpl({required ApiService apiService})
    : super(apiService: apiService);

  @override
  Future<ApiResult<LoginResponse?>> login(String email, String password) {
    return safeApiCall(() async {
      return await apiService?.login(
        LoginRequestBody(email: email, password: password),
      );
    });
  }
}
