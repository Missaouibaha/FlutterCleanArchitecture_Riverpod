import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/featues/profile/domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<ApiResult<ProfileEntity?>> getProfile();
}
