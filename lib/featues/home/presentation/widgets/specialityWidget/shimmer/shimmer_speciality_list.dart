import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:clean_arch_riverpod/core/utils/app_consts.dart';
import 'package:clean_arch_riverpod/featues/home/presentation/widgets/specialityWidget/shimmer/item_shimmer_speciality.dart';
import 'package:flutter/material.dart';

class ShimmerSpecialityList extends StatelessWidget {
  const ShimmerSpecialityList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.height_120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: AppConsts.specialityListCount,
        itemBuilder: (context, index) {
          return const ItemShimmerSpeciality();
        },
      ),
    );
  }
}
