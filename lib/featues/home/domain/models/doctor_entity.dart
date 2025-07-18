import 'package:clean_arch_riverpod/featues/home/data/data_sources/models/city.dart';
import 'package:clean_arch_riverpod/featues/home/domain/models/speciality_entity.dart';

class DoctorEntity {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? photoUrl;
  final String? gender;
  final String? address;
  final String? description;
  final String? degree;
  final int? appointPrice;
  final SpecialityEntity? specialization;
  final City? city;

  DoctorEntity({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.photoUrl,
    this.address,
    this.description,
    this.degree,
    this.gender,
    this.appointPrice,
    this.city,
    this.specialization,
  });
}
