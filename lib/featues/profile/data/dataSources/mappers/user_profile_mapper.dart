import 'package:clean_arch_riverpod/featues/profile/data/dataSources/models/user_profile_data.dart';
import 'package:clean_arch_riverpod/featues/profile/domain/entities/profile_entity.dart';

extension UserProfileMapper on UserProfileData {
  ProfileEntity toDomain() {
    return ProfileEntity(id, name, email, phone, gender);
  }

}
