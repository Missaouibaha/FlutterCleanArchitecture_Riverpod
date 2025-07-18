import 'package:clean_arch_riverpod/featues/signin/data/data_sources/remote/models/user_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  String? message;
  bool? status;
  int? code;
  @JsonKey(name: 'data')
  UserData? userData;
  LoginResponse({this.message, this.code, this.status, this.userData});
  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}
