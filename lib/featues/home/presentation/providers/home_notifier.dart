import 'dart:async';

import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:clean_arch_riverpod/featues/home/domain/models/home_data_entity.dart';
import 'package:clean_arch_riverpod/featues/home/domain/providers/home_domain_providers.dart';
import 'package:clean_arch_riverpod/featues/home/domain/use_cases/home_data_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeNotifier extends AsyncNotifier<List<HomeDataEntity>?> {
  late HomeDataUseCase _homeUseCases;

  @override
  FutureOr<List<HomeDataEntity>?> build() async {
    _homeUseCases = await ref.read(homeDataUseCasesProvider.future);
    final result = await _homeUseCases.call();
    return result.when(
      success: (data) {
        return data;
      },
      failure: (errorHandler) {
        throw errorHandler.apiErrorModel.message ?? AppStrings.unknownError;
      },
    );
  }
}

final homeNotifierProvider =
    AsyncNotifierProvider<HomeNotifier, List<HomeDataEntity>?>(
      () => HomeNotifier(),
    );
