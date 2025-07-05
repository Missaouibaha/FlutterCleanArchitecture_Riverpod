import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'governorate.g.dart';

@JsonSerializable()
@HiveType(typeId: 5)
class Governorate extends Equatable {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? name;
  Governorate(this.id, this.name);
  factory Governorate.fromJson(Map<String, dynamic> json) =>
      _$GovernorateFromJson(json);

  @override
  List<Object?> get props => [id, name];
}
