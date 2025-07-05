import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'specialization.g.dart';

@JsonSerializable()
@HiveType(typeId: 3)
class Specialization extends Equatable {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  String? specialityIconUrl = "";

  Specialization(this.id, this.name, this.specialityIconUrl);

  factory Specialization.fromJson(Map<String, dynamic> json) =>
      _$SpecializationFromJson(json);

  @override
  List<Object?> get props => [id, name, specialityIconUrl];
}
