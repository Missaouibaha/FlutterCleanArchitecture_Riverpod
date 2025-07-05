import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/featues/home/domain/models/home_data_entity.dart';
import 'package:clean_arch_riverpod/featues/home/domain/repository/home_repository.dart';

class HomeDataUseCase {
  final HomeRepository homeRepo;
  HomeDataUseCase(this.homeRepo);

  Future<ApiResult<List<HomeDataEntity>?>> call() async {
    return await homeRepo.getHomeData();
  }
}
