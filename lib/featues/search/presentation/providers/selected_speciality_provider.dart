import 'package:clean_arch_riverpod/core/utils/app_consts.dart';
import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:clean_arch_riverpod/featues/home/domain/models/speciality_entity.dart';
import 'package:clean_arch_riverpod/featues/search/presentation/providers/doctor_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedSpecialityIdProvider = StateProvider<int>((ref) => AppConsts.fakeSpecialityAllId,
);

final specialityFilterListProvider = Provider<List<SpecialityEntity>>((ref) {
  final selectedId = ref.watch(selectedSpecialityIdProvider);
  final doctorState = ref.watch(doctorNotifierProvider);

  return doctorState.when(
    data: (docs) {
      var specialities =
          docs
              ?.map((doc) => doc.specialization)
              .whereType<SpecialityEntity>()
              .toSet()
              .toList();
      specialities?.insert(
        0,
        SpecialityEntity(
          AppConsts.fakeSpecialityAllId,
          AppStrings.fakeSpecialityAllLabel,
          "",
          true,
        ),
      );
      return (specialities ?? [])
          .map(
            (spec) => SpecialityEntity(
              spec?.id,
              spec?.name,
              spec?.spacilityIconUrl,
              spec?.id == selectedId,
            ),
          )
          .toSet()
          .toList();
    },
    error: (error, stackTrace) {
      return [];
    },
    loading: () {
      return [];
    },
  );
});
