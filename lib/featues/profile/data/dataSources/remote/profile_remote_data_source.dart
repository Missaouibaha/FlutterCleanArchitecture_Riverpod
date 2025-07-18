import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/featues/profile/data/dataSources/models/profile_response.dart';

abstract class ProfileRemoteDataSource {
  Future<ApiResult<ProfileResponse?>> getProfile(String token);
}
