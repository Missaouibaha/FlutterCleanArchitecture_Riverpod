import 'package:clean_arch_riverpod/core/helper/spacing.dart';
import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:clean_arch_riverpod/core/theming/text_styles.dart';
import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:clean_arch_riverpod/featues/home/domain/models/doctor_entity.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  final DoctorEntity doctor;
  const AboutPage({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppDimensions.padding_10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          verticalSpace(AppDimensions.height_30),
          Text(AppStrings.aboutMe, style: TextStyles.font20BlueSemiBold),
          verticalSpace(AppDimensions.height_10),
          Text(
            AppStrings.aboutMeDescription
                .replaceAll(
                  '{'
                  '${AppStrings.name}'
                  '}',
                  doctor?.name ?? '',
                )
                .replaceAll(
                  '{'
                  '${AppStrings.doctorSpeciality}'
                  '}',
                  doctor?.specialization?.name ?? '',
                ),
            style: TextStyles.font14BlackRegular,
          ),
          verticalSpace(AppDimensions.height_15),
          Text(AppStrings.workingTime, style: TextStyles.font20BlueSemiBold),
          verticalSpace(AppDimensions.height_15),
          Text(AppStrings.workingTimes, style: TextStyles.font14BlackRegular),
          verticalSpace(AppDimensions.height_15),
          Text(
            AppStrings.appointmentPrice,
            style: TextStyles.font20BlueSemiBold,
          ),
          verticalSpace(AppDimensions.height_15),
          Text(
            " ${doctor?.appointPrice}",
            style: TextStyles.font14BlackRegular,
          ),
        ],
      ),
    );
  }
}
