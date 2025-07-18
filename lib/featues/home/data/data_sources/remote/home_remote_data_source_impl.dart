import 'package:clean_arch_riverpod/core/base/base_remote_data_source.dart';
import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/featues/home/data/data_sources/models/home_response.dart';
import 'package:clean_arch_riverpod/featues/home/data/data_sources/remote/home_remote_data_source.dart';

class HomeRemoteDataSourceImpl extends BaseRemoteDataSource
    implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl({super.apiService});
  @override
  Future<ApiResult<HomeResponse?>> getHomeData(String? token) async {
    return safeApiCall(() async {
      return await apiService?.getHomeData('Bearer $token');
    });
  }
}
