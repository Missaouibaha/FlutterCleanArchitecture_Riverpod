import 'package:clean_arch_riverpod/core/helper/extensions.dart';
import 'package:clean_arch_riverpod/core/theming/app_assets.dart';
import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:clean_arch_riverpod/core/theming/colors_manager.dart';
import 'package:clean_arch_riverpod/core/theming/text_styles.dart';
import 'package:clean_arch_riverpod/featues/home/domain/models/doctor_entity.dart';
import 'package:flutter/material.dart';

class TopDetailsWidget extends StatelessWidget {
  final DoctorEntity doctor;

  const TopDetailsWidget({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          margin: EdgeInsets.zero,
          child: Container(
            height: AppDimensions.height_250,
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorsManager.brown,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(AppDimensions.radius_16),
                bottomRight: Radius.circular(AppDimensions.radius_16),
              ),
            ),
            child: _buildDoctorImage(),
          ),
        ),
        Positioned(
          height: AppDimensions.height_50,
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            decoration: BoxDecoration(
              color: ColorsManager.brownHint,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(AppDimensions.radius_16),
                bottomRight: Radius.circular(AppDimensions.radius_16),
              ),
            ),
            child: Center(
              child: Text(
                doctor.name ?? '',
                textAlign: TextAlign.center,
                style: TextStyles.font20WhiteSemiBold,
              ),
            ),
          ),
        ),
        Positioned(
          top: AppDimensions.height_5,
          left: AppDimensions.width_5,
          child: GestureDetector(
            onTap: () => context.pop(),
            child: CircleAvatar(
              backgroundColor: ColorsManager.transparentBrown,
              child: Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
            ),
          ),
        ),

        Positioned(
          top: AppDimensions.height_5,
          right: AppDimensions.width_5,
          child: GestureDetector(
            child: CircleAvatar(
              backgroundColor: ColorsManager.transparentBrown,
              child: Icon(Icons.more_horiz, color: Colors.white),
            ),
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildDoctorImage() {
    return Hero(
      tag: doctor.id ?? 0,
      child: Image.network(
        doctor.photoUrl ?? '',
        width: AppDimensions.width_250,
        height: AppDimensions.height_210,
        errorBuilder:
            (context, error, stackTrace) => Image.asset(
              AppAssets.doctorImage,
              fit: BoxFit.fitHeight,
              width: AppDimensions.width_250,
              height: AppDimensions.height_250,
            ),
      ),
    );
  }
}
