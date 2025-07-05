import 'package:clean_arch_riverpod/core/helper/spacing.dart';
import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:clean_arch_riverpod/core/theming/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ItemShimmerSpeciality extends StatelessWidget {
  const ItemShimmerSpeciality({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.padding_12,
        vertical: AppDimensions.verticalPadding_8,
      ),
      child: Shimmer.fromColors(
        baseColor: ColorsManager.grayShade300,
        highlightColor: ColorsManager.grayShade100,
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radius_25),
              ),
              child: Container(
                width: AppDimensions.width_50,
                height: AppDimensions.width_50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimensions.padding_25),
                  border: Border.all(color: ColorsManager.lightGray),
                ),
              ),
            ),
            verticalSpace(AppDimensions.height_12),
            Container(
              width: AppDimensions.width_50,
              height: AppDimensions.height_12,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
    
  }
}