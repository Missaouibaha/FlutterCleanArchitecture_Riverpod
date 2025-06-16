import 'package:clean_arch_riverpod/featues/signin/data/data_sources/remote/models/user_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  final String? message;
  final bool? status;
  final int? code;
  @JsonKey(name: 'data')
  final UserData? userData;

  RegisterResponse(this.message, this.status, this.code, this.userData);
  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);
}
