import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/featues/search/data/data_sources/models/doctors_response.dart';

abstract class SearchRemoteDataSources {
  Future<ApiResult<DoctorsResponse?>> getDoctors(String token);
}
