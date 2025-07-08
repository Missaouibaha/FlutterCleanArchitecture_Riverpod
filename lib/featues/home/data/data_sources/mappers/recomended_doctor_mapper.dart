import 'package:clean_arch_riverpod/featues/home/data/data_sources/models/doctor.dart';
import 'package:clean_arch_riverpod/featues/home/domain/models/doctor_entity.dart';
import 'package:clean_arch_riverpod/featues/home/domain/models/speciality_entity.dart';

extension RecomendedDoctorMapper on Doctor {
  DoctorEntity toDomain() {
    return DoctorEntity(
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
      specialization: SpecialityEntity(
        specialization?.id,
        specialization?.name,
        specialization?.specialityIconUrl,
        false,
      ),
    );
  }

  SpecialityEntity toSpecDomain() {
    return SpecialityEntity(
      specialization?.id,
      specialization?.name,
      specialization?.specialityIconUrl,
      false,
    );
  }
}
