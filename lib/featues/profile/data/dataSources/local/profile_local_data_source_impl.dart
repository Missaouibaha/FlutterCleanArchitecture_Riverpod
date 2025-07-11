import 'package:clean_arch_riverpod/core/base/base_local_data_source.dart';
import 'package:clean_arch_riverpod/core/services/hive_keys.dart';
import 'package:clean_arch_riverpod/featues/profile/data/dataSources/local/profile_local_data_source.dart';
import 'package:clean_arch_riverpod/featues/profile/data/dataSources/models/user_profile_data.dart';

class ProfileLocalDataSourceImpl extends BaseLocalDataSource
    implements ProfileLocalDataSource {
  ProfileLocalDataSourceImpl({super.hive, super.prefs});
  @override
  Future<String> getUserToken() async {
    return await getToken();
  }

  @override
  Future<UserProfileData?> getProfileData() async {
    return await getCached<UserProfileData?>(
      HiveKeys.userProfileBox,
      HiveKeys.profile,
    );
  }

  @override
  Future<void> saveProfileData(UserProfileData profile) async {
    await cache<UserProfileData>(
      HiveKeys.userProfileBox,
      HiveKeys.profile,
      profile,
    );
  }
}
