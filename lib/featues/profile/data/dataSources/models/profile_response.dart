import 'package:clean_arch_riverpod/featues/profile/data/dataSources/models/user_profile_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse {
  String? message;
  @JsonKey(name: 'data')
  List<UserProfileData>? profileData;
  bool? status;
  int? code;
  ProfileResponse({this.message, this.profileData, this.status, this.code});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);
}
