import 'package:clean_arch_riverpod/featues/profile/data/dataSources/models/user_profile_data.dart';

abstract class ProfileLocalDataSource {
  Future<String> getUserToken();
  Future<UserProfileData?> getProfileData();
  Future<void> saveProfileData(UserProfileData profile);
}
