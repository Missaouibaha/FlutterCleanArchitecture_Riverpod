import 'package:clean_arch_riverpod/featues/home/data/data_sources/models/doctor.dart';
import 'package:clean_arch_riverpod/featues/home/domain/models/recomended_doctor_entity.dart';

extension RecomendedDoctorMapper on Doctor {
  RecomendedDoctorEntity toDomain() {
    return RecomendedDoctorEntity(
      id: id,
      name: name,
      email: email,
      phone: phone,
      photoUrl: photoUrl,
      gender: gender,
      address: address,
      description: description,
      degree: degree,
      appointPrice: appointPrice,
      city: city,
      specialization: specialization,
    );
  }
}
