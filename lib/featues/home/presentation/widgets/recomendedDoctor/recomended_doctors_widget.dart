import 'package:clean_arch_riverpod/core/theming/app_assets.dart';
import 'package:clean_arch_riverpod/core/utils/app_consts.dart';
import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:clean_arch_riverpod/featues/home/data/data_sources/models/specialization.dart';
import 'package:clean_arch_riverpod/featues/home/domain/models/recomended_doctor_entity.dart';
import 'package:clean_arch_riverpod/featues/home/presentation/providers/home_notifier.dart';
import 'package:clean_arch_riverpod/featues/home/presentation/widgets/recomendedDoctor/item_recomended_doctor.dart';
import 'package:clean_arch_riverpod/featues/home/presentation/widgets/recomendedDoctor/shimmer/shimmer_recomended_doctor_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecomendedDoctorsWidget extends ConsumerWidget {
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
        RecomendedDoctorEntity fakeDoctor = RecomendedDoctorEntity(
          id: -1,
          name: AppStrings.defaultRecomDoc,
          photoUrl: AppAssets.doctorImage,
          degree: AppStrings.defaultDegreeDoc,
          specialization: Specialization(
            1,
            AppStrings.defaultSpecialityDoc,
            '',
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
