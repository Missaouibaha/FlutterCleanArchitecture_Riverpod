import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:clean_arch_riverpod/core/theming/colors_manager.dart';
import 'package:clean_arch_riverpod/core/theming/text_styles.dart';
import 'package:flutter/material.dart';

class DividerWithText extends StatelessWidget {
  final String text;
  const DividerWithText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Divider(
          color: ColorsManager.lightGray,
          thickness: AppDimensions.dividerThickness_2,
          endIndent: AppDimensions.padding_5,
          indent: AppDimensions.padding_5,
        ),
        Text(text, style: TextStyles.font16LightGrayMedium),
        Divider(
          color: ColorsManager.lightGray,
          thickness: AppDimensions.dividerThickness_2,
          endIndent: AppDimensions.padding_5,
          indent: AppDimensions.padding_5,
        ),
      ],
    );
  }
}
