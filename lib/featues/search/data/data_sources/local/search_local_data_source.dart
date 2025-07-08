import 'package:clean_arch_riverpod/featues/home/data/data_sources/models/doctor.dart';

abstract class SearchLocalDataSource {
  Future<String> getUserToken();
  Future<List<Doctor>?> getDoctors();
  Future<void> cacheDoctors(List<Doctor> doctors);
}
