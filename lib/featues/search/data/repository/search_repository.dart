import 'package:clean_arch_riverpod/core/helper/extensions.dart';
import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/featues/home/data/data_sources/mappers/recomended_doctor_mapper.dart';
import 'package:clean_arch_riverpod/featues/home/domain/models/doctor_entity.dart';
import 'package:clean_arch_riverpod/featues/search/data/data_sources/local/search_local_data_source.dart';
import 'package:clean_arch_riverpod/featues/search/data/data_sources/remote/search_remote_data_sources.dart';
import 'package:clean_arch_riverpod/featues/search/domain/repository/doctors_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSources _remoteData;
  final SearchLocalDataSource _localData;
  SearchRepositoryImpl(this._remoteData, this._localData);

  @override
  Future<ApiResult<List<DoctorEntity>?>> getDoctors(bool refresh) async {
    final token = await _localData.getUserToken();
    final localDoctors = await _localData.getDoctors();

    if (!refresh && !localDoctors.isNullOrEmpty) {
      return ApiResult.success(
        localDoctors?.map((doc) => doc.toDomain()).toSet().toList(),
      );
    }

    final result = await _remoteData.getDoctors(token);

    return result.when(
      success: (data) async {
        final remoteDoctors = data?.doctors;
        if (localDoctors != remoteDoctors && !remoteDoctors.isNullOrEmpty) {
          await _localData?.cacheDoctors(remoteDoctors!);
          return ApiResult.success(
            remoteDoctors?.map((doc) => doc.toDomain()).toSet().toList(),
          );
        }
        return ApiResult.success(
          localDoctors?.map((doc) => doc.toDomain()).toSet().toList(),
        );
      },
      failure: (errorHandler) {
        return ApiResult.failure(errorHandler);
      },
    );
  }
}
