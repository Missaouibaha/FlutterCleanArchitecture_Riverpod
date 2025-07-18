import 'package:clean_arch_riverpod/core/base/base_local_data_source.dart';
import 'package:clean_arch_riverpod/core/services/hive_keys.dart';
import 'package:clean_arch_riverpod/featues/home/data/data_sources/models/doctor.dart';
import 'package:clean_arch_riverpod/featues/search/data/data_sources/local/search_local_data_source.dart';

class SearchLocalDataSourceImpl extends BaseLocalDataSource
    implements SearchLocalDataSource {
  SearchLocalDataSourceImpl({super.hive, super.prefs});
  @override
  Future<String> getUserToken() async {
    return await getToken();
  }

  @override
  Future<List<Doctor>?> getDoctors() async {
    return await getCachedList<Doctor>(HiveKeys.doctorsListBox);
  }

  @override
  Future<void> cacheDoctors(List<Doctor> doctors) async {
    await cacheList<Doctor>(HiveKeys.doctorsListBox, doctors);
  }
}
