import 'package:clean_arch_riverpod/core/helper/spacing.dart';
import 'package:clean_arch_riverpod/core/theming/app_assets.dart';
import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:clean_arch_riverpod/core/theming/colors_manager.dart';
import 'package:clean_arch_riverpod/core/theming/text_styles.dart';
import 'package:clean_arch_riverpod/featues/home/domain/models/speciality_entity.dart';
import 'package:flutter/material.dart';

class ItemSpeciality extends StatelessWidget {
  final SpecialityEntity? speciality;
  const ItemSpeciality({super.key, required this.speciality});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.padding_12,
        vertical: AppDimensions.verticalPadding_8,
      ),
      child: Column(
        children: [
          Card(
            color: ColorsManager.lightBlue,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radius_25),
            ),
            child: Padding(
              padding: EdgeInsets.all(AppDimensions.padding_12),
              child: Image.network(
                height: AppDimensions.height_30,
                width: AppDimensions.width_30,
                speciality?.spacilityIconUrl ?? '',
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    AppAssets.iconCardioSpeciality,
                    width: AppDimensions.width_30,
                    height: AppDimensions.height_30,
                    fit: BoxFit.contain,
                  );
                },
              ),
            ),
          ),
          verticalSpace(AppDimensions.height_12),
          SizedBox(
            width: AppDimensions.width_70,
            child: Text(
              textAlign: TextAlign.center,
              speciality?.name ?? "",
              style: TextStyles.font13BlackMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
