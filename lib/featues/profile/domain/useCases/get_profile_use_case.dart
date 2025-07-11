import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/featues/profile/domain/entities/profile_entity.dart';
import 'package:clean_arch_riverpod/featues/profile/domain/repository/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository _profileRepository;
  GetProfileUseCase(this._profileRepository);

  Future<ApiResult<ProfileEntity?>> call() async {
    return await _profileRepository.getProfile();
  }
}
