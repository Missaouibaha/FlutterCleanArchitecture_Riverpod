import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/featues/profile/data/dataSources/local/profile_local_data_source.dart';
import 'package:clean_arch_riverpod/featues/profile/data/dataSources/mappers/user_profile_mapper.dart';
import 'package:clean_arch_riverpod/featues/profile/data/dataSources/remote/profile_remote_data_source.dart';
import 'package:clean_arch_riverpod/featues/profile/domain/entities/profile_entity.dart';
import 'package:clean_arch_riverpod/featues/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _profileRemoteDataSource;
  final ProfileLocalDataSource _profileLocalDataSource;
  ProfileRepositoryImpl(
    this._profileRemoteDataSource,
    this._profileLocalDataSource,
  );
  @override
  Future<ApiResult<ProfileEntity?>> getProfile() async {
    final token = await _profileLocalDataSource.getUserToken();
    final profile = await _profileLocalDataSource.getProfileData();
    if (profile != null) {
      return ApiResult.success(profile.toDomain());
    } else {
      final result = await _profileRemoteDataSource.getProfile(token);
      return result.when(
        success: (data) {
          final profile = data?.profileData?.elementAt(0);
          return ApiResult.success(profile?.toDomain());
        },
        failure: (errorHandler) {
          return ApiResult.failure(errorHandler);
        },
      );
    }
  }
}
