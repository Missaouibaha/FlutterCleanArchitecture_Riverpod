import 'dart:async';

import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:clean_arch_riverpod/featues/home/domain/models/doctor_entity.dart';
import 'package:clean_arch_riverpod/featues/search/domain/providers/search_domain_providers.dart';
import 'package:clean_arch_riverpod/featues/search/domain/useCases/search_doctor_use_case.dart';
import 'package:clean_arch_riverpod/featues/search/presentation/providers/refresh_data_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DoctorNotifier extends AsyncNotifier<List<DoctorEntity>?> {
  late SearchDoctorUseCase _useCase;

  @override
  FutureOr<List<DoctorEntity>?> build() async {
    _useCase = await ref.read(searchUseCasesProvider.future);
    final refresh = ref.read(refreshDataProvider);
    return await getDoctors(refresh); // initial fetch
  }

  Future<List<DoctorEntity>?> getDoctors(bool refreshData) async {

    final result = await _useCase.call(refreshData);

    return result.when(
      success: (doctorList) {
        ref.read(refreshDataProvider.notifier).state = false;
        state = AsyncValue.data(doctorList);
        return doctorList;
      },
      failure: (errorHandler) {
        ref.read(refreshDataProvider.notifier).state = false;
        throw errorHandler.apiErrorModel.message ?? AppStrings.unknownError;
      },
    );
  }
}

final doctorNotifierProvider =
    AsyncNotifierProvider<DoctorNotifier, List<DoctorEntity>?>(
      () => DoctorNotifier(),
    );
