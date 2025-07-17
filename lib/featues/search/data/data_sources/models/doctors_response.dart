import 'package:clean_arch_riverpod/featues/home/data/data_sources/models/doctor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'doctors_response.g.dart';

@JsonSerializable()
class DoctorsResponse {
  int? code;
  String? message;
  bool? status;
  @JsonKey(name: 'data')
  List<Doctor>? doctors;

  DoctorsResponse(this.code, this.message, this.status, this.doctors);

  factory DoctorsResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorsResponseFromJson(json);
}
