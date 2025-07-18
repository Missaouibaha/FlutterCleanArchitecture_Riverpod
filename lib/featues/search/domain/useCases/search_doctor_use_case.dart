import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/featues/home/domain/models/doctor_entity.dart';
import 'package:clean_arch_riverpod/featues/search/domain/repository/doctors_repository.dart';

class SearchDoctorUseCase {
  final SearchRepository repository;
  SearchDoctorUseCase(this.repository);

  Future<ApiResult<List<DoctorEntity>?>> call(bool refresh) async {
    return await repository.getDoctors(refresh);
  }
}
