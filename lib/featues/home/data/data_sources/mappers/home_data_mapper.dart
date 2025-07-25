import 'package:clean_arch_riverpod/featues/home/data/data_sources/models/home_data.dart';
import 'package:clean_arch_riverpod/featues/home/domain/models/doctor_entity.dart';
import 'package:clean_arch_riverpod/featues/home/domain/models/home_data_entity.dart';
import 'package:clean_arch_riverpod/featues/home/domain/models/speciality_entity.dart';

extension HomeDataMapper on HomeData {
  HomeDataEntity toEntity() {
    final speciality = SpecialityEntity(id, name, "", false);

    final recomendedDoctors =
        doctors
            ?.map((doc) {
              return DoctorEntity(
                id: doc.id,
                name: doc.name,
                email: doc.email,
                phone: doc.phone,
                photoUrl: doc.photoUrl,
                gender: doc.gender,
                address: doc.address,
                description: doc.description,
                degree: doc.degree,
                appointPrice: doc.appointPrice,
                city: doc.city,
                specialization: speciality,
              );
            })
            .toSet()
            .toList();

    return HomeDataEntity(speciality, recomendedDoctors);
  }
}
