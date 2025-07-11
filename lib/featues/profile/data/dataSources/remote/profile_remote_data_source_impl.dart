import 'package:clean_arch_riverpod/core/base/base_remote_data_source.dart';
import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/featues/profile/data/dataSources/models/profile_response.dart';
import 'package:clean_arch_riverpod/featues/profile/data/dataSources/remote/profile_remote_data_source.dart';

class ProfileRemoteDataSourceImpl extends BaseRemoteDataSource
    implements ProfileRemoteDataSource {
  ProfileRemoteDataSourceImpl({super.apiService});
  @override
  Future<ApiResult<ProfileResponse?>> getProfile(String token) {
    return safeApiCall(() async {
      return await apiService?.getProfile('Bearer $token');
    });
  }
}
