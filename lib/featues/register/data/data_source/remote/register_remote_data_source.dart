import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/featues/register/data/data_source/remote/models/register_request_body.dart';
import 'package:clean_arch_riverpod/featues/register/data/data_source/remote/models/register_response.dart';

abstract class RegisterRemoteDataSource {
  Future<ApiResult<RegisterResponse?>> register(
    RegisterRequestBody registerRequestBody,
  );
}
