import 'package:clean_arch_riverpod/featues/home/data/data_sources/models/home_data.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/local/models/user_local.dart';

abstract class HomeLocalDataSource {
  Future<UserLocal?> getUser();
  Future<List<HomeData>?> getHomeDataList();

  Future<void> cacheHomeDataList(List<HomeData> homeDataEntities);
}
