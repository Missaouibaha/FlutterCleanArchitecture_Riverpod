import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/featues/home/domain/models/home_data_entity.dart';
import 'package:clean_arch_riverpod/featues/signin/domain/entities/user.dart';

abstract class HomeRepository {
  Future<User?> getUser();
  Future<ApiResult<List<HomeDataEntity>?>> getHomeData();
}
