import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile_data.g.dart';

@JsonSerializable()
@HiveType(typeId: 6)
class UserProfileData {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String? phone;
  @HiveField(4)
  String? gender;
  UserProfileData({this.id, this.name, this.email, this.phone, this.gender});
  factory UserProfileData.fromJson(Map<String, dynamic> json) =>
      _$UserProfileDataFromJson(json);
}
