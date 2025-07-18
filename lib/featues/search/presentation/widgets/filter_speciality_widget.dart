import 'package:clean_arch_riverpod/core/helper/extensions.dart';
import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:clean_arch_riverpod/core/theming/colors_manager.dart';
import 'package:clean_arch_riverpod/core/utils/app_consts.dart';
import 'package:clean_arch_riverpod/featues/search/presentation/providers/selected_speciality_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class FilterSpecialityWidget extends StatefulWidget {
  const FilterSpecialityWidget({super.key});

  @override
  State<FilterSpecialityWidget> createState() => _FilterSpecialityWidgetState();
}

class _FilterSpecialityWidgetState extends State<FilterSpecialityWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final specialityList = ref.watch(specialityFilterListProvider);

        if (specialityList.isNullOrEmpty ||
            specialityList.length < AppConsts.minSpecialityListLength) {
          return Shimmer.fromColors(
            baseColor: ColorsManager.grayShade300,
            highlightColor: ColorsManager.grayShade100,
            child: SizedBox(
              height: AppDimensions.height_50,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: AppConsts.specialityShimmerListCount,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.padding_15,
                      vertical: AppDimensions.padding_10,
                    ),
                    margin: EdgeInsets.all(AppDimensions.padding_4),
                    decoration: BoxDecoration(
                      color: ColorsManager.lightGray,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radius_12,
                      ),
                    ),
                    child: SizedBox(
                      width: AppDimensions.width_50,
                      height: AppDimensions.height_30,
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return SizedBox(
            height: AppDimensions.height_50,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: specialityList.length,

              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap:
                      () => setState(() {
                        ref.read(selectedSpecialityIdProvider.notifier).state =
                            specialityList.elementAt(index)?.id ?? 0;
                      }),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.padding_15,
                      vertical: AppDimensions.padding_10,
                    ),
                    margin: EdgeInsets.all(AppDimensions.padding_4),
                    decoration: BoxDecoration(
                      color:
                          specialityList.elementAt(index)?.isSelected ?? false
                              ? ColorsManager.mainBlue
                              : ColorsManager.grayShade300,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radius_12,
                      ),
                    ),
                    child: Text(
                      specialityList.elementAt(index)?.name ?? "",
                      style: TextStyle(
                        color:
                            specialityList.elementAt(index)?.isSelected ?? false
                                ? ColorsManager.white
                                : ColorsManager.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
