import 'package:clean_arch_riverpod/core/base/base_local_data_source.dart';
import 'package:clean_arch_riverpod/core/services/hive_keys.dart';
import 'package:clean_arch_riverpod/featues/home/data/data_sources/local/home_local_data_source.dart';
import 'package:clean_arch_riverpod/featues/home/data/data_sources/models/home_data.dart';
import 'package:clean_arch_riverpod/featues/signin/data/data_sources/local/models/user_local.dart';

class HomeLocalDataSourceImpl extends BaseLocalDataSource
    implements HomeLocalDataSource {
  HomeLocalDataSourceImpl({super.hive, super.prefs});
  @override
  Future<UserLocal?> getUser() async {
    return await getCached<UserLocal?>(HiveKeys.connectedUserBox, HiveKeys.user);
  }

  @override
  Future<void> cacheHomeDataList(List<HomeData> homeDataList) async {
    await cacheList<HomeData>(HiveKeys.homeDataListBox, homeDataList);
  }
  
    @override
  Future<List<HomeData>?> getHomeDataList() async {
    return await getCachedList<HomeData>(HiveKeys.homeDataListBox);
  }
}
