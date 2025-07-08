import 'package:clean_arch_riverpod/core/base/base_remote_data_source.dart';
import 'package:clean_arch_riverpod/core/networking/api_constants.dart';
import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/featues/search/data/data_sources/models/doctors_response.dart';
import 'package:clean_arch_riverpod/featues/search/data/data_sources/remote/search_remote_data_sources.dart';

class SearchRemoteDataSourcesImpl extends BaseRemoteDataSource
    implements SearchRemoteDataSources {
  SearchRemoteDataSourcesImpl({super.apiService});

  @override
  Future<ApiResult<DoctorsResponse?>> getDoctors(String token) async {
    return safeApiCall(() async {
      return await apiService?.getDoctors('${ApiConstants.bearer} $token');
    });
  }
}
