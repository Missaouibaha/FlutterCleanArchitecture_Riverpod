import 'package:clean_arch_riverpod/core/helper/spacing.dart';
import 'package:clean_arch_riverpod/core/theming/app_assets.dart';
import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:clean_arch_riverpod/core/theming/colors_manager.dart';
import 'package:clean_arch_riverpod/core/theming/text_styles.dart';
import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:clean_arch_riverpod/core/widgets/app_text_button.dart';
import 'package:flutter/material.dart';

class TopCardViewDoctor extends StatelessWidget {
  const TopCardViewDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.height_230,
      child: Stack(
        // allow overflow
        clipBehavior: Clip.none,

        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radius_10),
            ),
            color: Colors.blue,
            child: SizedBox(
              height: AppDimensions.height_180,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: AppDimensions.padding_15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.bookNearesrDoctor,
                          style: TextStyles.font14WhiteSemiBold,
                        ),
                        verticalSpace(AppDimensions.height_10),
                        AppTextButton(
                          textButton: AppStrings.findNearby,
                          textStyle: TextStyles.font13BlueMedium,
                          onPressed: () {},
                          buttonWidth: AppDimensions.width_90,
                          buttonHeigh: AppDimensions.height_40,
                          backgroundColor: ColorsManager.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            right: AppDimensions.width_10,
            top: -AppDimensions.height_30,
            child: Image.asset(
              AppAssets.doctorImage,
              width: AppDimensions.width_150,
              height: AppDimensions.height_210,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
