import 'package:clean_arch_riverpod/core/helper/spacing.dart';
import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:clean_arch_riverpod/core/theming/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ItemShimmerRecomendedDoc extends StatelessWidget {
  const ItemShimmerRecomendedDoc({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppDimensions.padding_10,
        horizontal: AppDimensions.padding_5,
      ),
      child: Shimmer.fromColors(
        baseColor: ColorsManager.grayShade300,
        highlightColor: ColorsManager.grayShade100,

        child: Row(
          children: [
            Container(
              height: AppDimensions.height_120,
              width: AppDimensions.width_100,
              color: ColorsManager.lightBlue,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: AppDimensions.width_70,
                      height: AppDimensions.height_25,

                      color: ColorsManager.lightBlue,
                    ),
                    verticalSpace(AppDimensions.height_8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: AppDimensions.width_50,
                          height: AppDimensions.height_20,
                          color: ColorsManager.lightBlue,
                        ),
                        horizontalSpace(AppDimensions.width_5),
                        Container(
                          width: AppDimensions.width_40,
                          height: AppDimensions.height_20,
                          color: ColorsManager.lightBlue,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
