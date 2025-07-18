import 'package:clean_arch_riverpod/featues/home/domain/models/doctor_entity.dart';
import 'package:clean_arch_riverpod/featues/search/presentation/providers/doctor_notifier.dart';
import 'package:clean_arch_riverpod/featues/search/presentation/providers/search_text_speciality_doctor_provider.dart';
import 'package:clean_arch_riverpod/featues/search/presentation/providers/selected_speciality_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterDoctorsNotifier extends AsyncNotifier<List<DoctorEntity>> {
  @override
  Future<List<DoctorEntity>> build() async {
    final searchedText = ref.watch(searchTextProvider).toLowerCase();
    final selectedSpecId = ref.watch(selectedSpecialityIdProvider);

    final doctorList = await ref.watch(doctorNotifierProvider.future);
    final filtredList =
        doctorList?.where((doctor) {
          final nameMatch = (doctor.name ?? '').toLowerCase().trim().contains(
            searchedText.toLowerCase(),
          );
          final specNameMatch = (doctor.specialization?.name ?? '')
              .toLowerCase()
              .trim()
              .contains(searchedText.toLowerCase());

          final isSearchMatch =
              searchedText.isEmpty || nameMatch || specNameMatch;

          final isSpecialityMatch =
              selectedSpecId == -1 ||
              doctor.specialization?.id == selectedSpecId;

          return isSearchMatch && isSpecialityMatch;
        }).toList() ??
        [];

    ref.read(lastSuccessfulDoctorListProvider.notifier).state = filtredList;

    return filtredList;
  }
}

final lastSuccessfulDoctorListProvider = StateProvider<List<DoctorEntity>?>(
  (ref) => null,
);

final filtredDoctorsProvider =
    AsyncNotifierProvider<FilterDoctorsNotifier, List<DoctorEntity>>(
      FilterDoctorsNotifier.new,
    );
