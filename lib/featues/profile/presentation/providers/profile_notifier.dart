import 'dart:async';

import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:clean_arch_riverpod/featues/profile/domain/entities/profile_entity.dart';
import 'package:clean_arch_riverpod/featues/profile/domain/providers/profile_domain_providers.dart';
import 'package:clean_arch_riverpod/featues/profile/domain/useCases/get_profile_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileNotifier extends AsyncNotifier<ProfileEntity?> {
  late GetProfileUseCase _profileUseCase;
  @override
  FutureOr<ProfileEntity?> build() async {
    _profileUseCase = await ref.read(profileUseCase.future);
    final profile = await _profileUseCase.call();
    return profile?.when(
      success: (userProfile) {
        return userProfile;
      },
      failure: (errorHandler) {

        throw errorHandler.apiErrorModel.message ?? AppStrings.unknownError;
      },
    );
  }
}

final profileNotifierProvider =
    AsyncNotifierProvider<ProfileNotifier, ProfileEntity?>(
      () => ProfileNotifier(),
    );
