import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:clean_arch_riverpod/core/theming/colors_manager.dart';
import 'package:clean_arch_riverpod/core/theming/text_styles.dart';
import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

class AppointmentsRecordsWidget extends StatelessWidget {
  const AppointmentsRecordsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.padding_20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.radius_8),
          color: ColorsManager.grayShade100,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.padding_5,
            vertical: AppDimensions.verticalPadding_2,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                AppStrings.appointments,
                style: TextStyles.font14DarckBlueMedium,
              ),
              SizedBox(
                height: AppDimensions.height_50,
                width: AppDimensions.width_5,
                child: VerticalDivider(
                  color: ColorsManager.black,
                  width: AppDimensions.width_5,
                  thickness: AppDimensions.width_2,
                ),
              ),
              Text(
                AppStrings.medicRecords,
                style: TextStyles.font14DarckBlueMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
