import 'package:clean_arch_riverpod/core/theming/app_assets.dart';
import 'package:clean_arch_riverpod/core/utils/app_consts.dart';
import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:clean_arch_riverpod/featues/home/domain/models/doctor_entity.dart';
import 'package:clean_arch_riverpod/featues/home/domain/models/speciality_entity.dart';
import 'package:clean_arch_riverpod/featues/home/presentation/providers/home_notifier.dart';
import 'package:clean_arch_riverpod/featues/home/presentation/widgets/recomendedDoctor/item_recomended_doctor.dart';
import 'package:clean_arch_riverpod/featues/home/presentation/widgets/recomendedDoctor/shimmer/shimmer_recomended_doctor_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecomendedDoctorsWidget extends ConsumerWidget {
  const RecomendedDoctorsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeNotifierProvider);
    return homeState.when(
      data: (data) {
        final doctors = data
            ?.map((homeData) => homeData.recomendedDoctors ?? [])
            .expand((doctorList) => doctorList)
            .toSet()
            .toList()
            .sublist(0, AppConsts.recomendedDocListCount);

        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: doctors?.length,
          itemBuilder: (context, index) {
            return ItemRecomendedDoctor(doctor: doctors?.elementAt(index));
          },
        );
      },
      error: (error, stackTrace) {
        DoctorEntity fakeDoctor = DoctorEntity(
          id: -1,
          name: AppStrings.defaultRecomDoc,
          photoUrl: AppAssets.doctorImage,
          degree: AppStrings.defaultDegreeDoc,
          specialization: SpecialityEntity(
            1,
            AppStrings.defaultSpecialityDoc,
            '',
             false,
          ),
        );

        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) {
            return ItemRecomendedDoctor(doctor: fakeDoctor);
          },
        );
      },
      loading: () {
        return ShimmerRecomendedDoctorList();
      },
    );
  }
}
