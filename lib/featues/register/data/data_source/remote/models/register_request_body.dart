import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'register_request_body.g.dart';

@JsonSerializable()
class RegisterRequestBody {
  String name;
  String email;
  String phone;
  String password;
  @JsonKey(name: 'password_confirmation')
  String confirmPassword;
  int gender;

  RegisterRequestBody(
    this.name,
    this.email,
    this.phone,
    this.password,
    this.confirmPassword,
    this.gender,
  );

  Map<String, dynamic> toJson() => _$RegisterRequestBodyToJson(this);
}
