import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/featues/home/domain/models/doctor_entity.dart';

abstract class SearchRepository {
  Future<ApiResult<List<DoctorEntity>?>> getDoctors(bool refresh);
}
