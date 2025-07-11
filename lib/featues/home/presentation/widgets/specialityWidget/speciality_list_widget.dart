import 'package:clean_arch_riverpod/core/theming/app_assets.dart';
import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:clean_arch_riverpod/core/utils/app_consts.dart';
import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:clean_arch_riverpod/featues/home/domain/models/speciality_entity.dart';
import 'package:clean_arch_riverpod/featues/home/presentation/providers/home_notifier.dart';
import 'package:clean_arch_riverpod/featues/home/presentation/widgets/specialityWidget/item_speciality.dart';
import 'package:clean_arch_riverpod/featues/home/presentation/widgets/specialityWidget/shimmer/shimmer_speciality_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SpecialityListWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeNotifierProvider);

    return homeState.when(
      loading: () => ShimmerSpecialityList(),
      error: (error, stack) {
        return SizedBox(
          height: AppDimensions.height_120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: AppConsts.specialityListCount,
            itemBuilder: (context, index) {
              return ItemSpeciality(
                speciality: SpecialityEntity(
                  -1,
                  AppStrings.defaultSpecialityDoc,
                  AppAssets.iconCardioSpeciality,
                  true
                ),
              );
            },
          ),
        );
      },
      data: (homeDataList) {
        final specialities =
            homeDataList?.map((data) => data.speciality).toSet().toList();

        return SizedBox(
          height: AppDimensions.height_120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: specialities?.length,
            itemBuilder: (context, index) {
              return ItemSpeciality(speciality: specialities?.elementAt(index));
            },
          ),
        );
      },
    );
  }
}
