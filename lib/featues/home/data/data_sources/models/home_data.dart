import 'package:clean_arch_riverpod/featues/home/data/data_sources/models/doctor.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_data.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class HomeData extends Equatable {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final List<Doctor>? doctors;

  HomeData(this.id, this.name, this.doctors);

  factory HomeData.fromJson(Map<String, dynamic> json) =>
      _$HomeDataFromJson(json);

  @override
  List<Object?> get props => [id, name, doctors];
}
