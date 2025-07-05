import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/featues/home/data/data_sources/models/home_response.dart';

abstract class HomeRemoteDataSource {
  Future<ApiResult<HomeResponse?>> getHomeData(String? token);
}
