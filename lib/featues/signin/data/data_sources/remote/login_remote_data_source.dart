import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/remote/models/login_response.dart';

abstract class LoginRemoteDataSource {
  Future<ApiResult<LoginResponse?>> login(String email, String password);
}
