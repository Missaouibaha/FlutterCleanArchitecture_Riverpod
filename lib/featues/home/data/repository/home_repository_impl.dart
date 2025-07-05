import 'package:clean_arch_riverpod/core/helper/extensions.dart';
import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/featues/home/data/data_sources/local/home_local_data_source.dart';
import 'package:clean_arch_riverpod/featues/home/data/data_sources/mappers/home_data_mapper.dart';
import 'package:clean_arch_riverpod/featues/home/data/data_sources/remote/home_remote_data_source.dart';
import 'package:clean_arch_riverpod/featues/home/domain/models/home_data_entity.dart';
import 'package:clean_arch_riverpod/featues/home/domain/repository/home_repository.dart';
import 'package:clean_arch_riverpod/featues/register/data/data_source/mappers/user_data_mapper.dart';
import 'package:clean_arch_riverpod/featues/signin/domain/entities/user.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDataSource _homeLocalDataSource;
  final HomeRemoteDataSource _homeRemoteDataSource;
  HomeRepositoryImpl(this._homeLocalDataSource, this._homeRemoteDataSource);
  @override
  Future<User?> getUser() async {
    final user = await _homeLocalDataSource.getUser();
    return user?.toDomain();
  }

  @override
  Future<ApiResult<List<HomeDataEntity>?>> getHomeData() async {
    final homeEntityList = await _homeLocalDataSource.getHomeDataList();
    final localData =
        homeEntityList?.map((element) => element.toEntity()).toSet().toList();

    final user = await _homeLocalDataSource.getUser();
    final response = await _homeRemoteDataSource.getHomeData(user?.token);

    return response.when(
      success: (result) async {
        final remoteData =
            result?.homeData
                .map((element) => element.toEntity())
                .toSet()
                .toList();

        if (localData != remoteData) {
          await result?.homeData.let(
            (it) => _homeLocalDataSource.cacheHomeDataList(it),
          );
          return ApiResult.success(remoteData);
        }
        return ApiResult.success(localData);
      },
      failure: (errorHandler) {
        if (localData.isNullOrEmpty) {
          return ApiResult.failure(errorHandler);
        } else {
          return ApiResult.success(localData);
        }
      },
    );
  }
}
