import 'package:clean_arch_riverpod/featues/home/domain/models/recomended_doctor_entity.dart';
import 'package:clean_arch_riverpod/featues/home/domain/models/speciality_entity.dart';

class HomeDataEntity {
  final SpecialityEntity speciality;
  final List<RecomendedDoctorEntity>? recomendedDoctors;

  HomeDataEntity(this.speciality, this.recomendedDoctors);
}
