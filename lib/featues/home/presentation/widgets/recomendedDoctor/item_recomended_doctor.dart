import 'package:clean_arch_riverpod/core/helper/spacing.dart';
import 'package:clean_arch_riverpod/core/theming/app_assets.dart';
import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:clean_arch_riverpod/core/theming/colors_manager.dart';
import 'package:clean_arch_riverpod/core/theming/text_styles.dart';
import 'package:clean_arch_riverpod/featues/home/domain/models/doctor_entity.dart';
import 'package:flutter/material.dart';

class ItemRecomendedDoctor extends StatelessWidget {
  final DoctorEntity? doctor;
  const ItemRecomendedDoctor({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppDimensions.padding_10,
        horizontal: AppDimensions.padding_5,
      ),
      child: Row(
        children: [
          Container(
            height: AppDimensions.height_120,
            width: AppDimensions.width_120,
            decoration: BoxDecoration(
              color: ColorsManager.brown,
              borderRadius: BorderRadius.all(
                Radius.circular(AppDimensions.radius_16),
              ),
            ),
            child: Image.network(
              doctor?.photoUrl ?? '',
              width: AppDimensions.width_70,
              height: AppDimensions.height_90,
              errorBuilder:
                  (context, error, stackTrace) =>
                      Image.asset(AppAssets.doctorImage),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(AppDimensions.padding_8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor?.name ?? '',
                    style: TextStyles.font15BlackSemiBold,
                  ),
                  verticalSpace(AppDimensions.height_8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${doctor?.specialization?.name ?? ''}   |",
                        style: TextStyles.font13BlackRegular,
                      ),
                      horizontalSpace(AppDimensions.width_5),
                      Text(
                        doctor?.degree ?? '',
                        style: TextStyles.font13BlackRegular,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
