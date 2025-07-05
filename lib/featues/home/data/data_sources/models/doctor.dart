import 'package:clean_arch_riverpod/featues/home/data/data_sources/models/city.dart';
import 'package:clean_arch_riverpod/featues/home/data/data_sources/models/specialization.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'doctor.g.dart';

@JsonSerializable()
@HiveType(typeId: 2)
class Doctor extends Equatable {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? email;
  @HiveField(3)
  final String? phone;
  @JsonKey(name: 'photo')
  @HiveField(4)
  final String? photoUrl;
  @HiveField(5)
  final String? gender;
  @HiveField(6)
  final String? address;
  @HiveField(7)
  final String? description;
  @HiveField(8)
  final String? degree;
  @HiveField(9)
  @JsonKey(name: 'appoint_price')
  final int? appointPrice;
  @HiveField(10)
  final Specialization? specialization;
  @HiveField(11)
  final City? city;

  Doctor(
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
  );

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    phone,
    photoUrl,
    address,
    description,
    degree,
    gender,
    appointPrice,
    city,
    specialization,
  ];
}
