import 'package:clean_arch_riverpod/featues/home/data/data_sources/models/governorate.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'city.g.dart';

@JsonSerializable()
@HiveType(typeId: 4)
class City extends Equatable {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? name;
  @JsonKey(name: 'governrate')
  @HiveField(2)
  final Governorate? governorate;

  City(this.id, this.name, this.governorate);

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  @override
  List<Object?> get props => [id, name, governorate];
}
