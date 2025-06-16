import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:clean_arch_riverpod/core/theming/text_styles.dart';
import 'package:flutter/material.dart';

class DividerWithText extends StatelessWidget {
  final String text;
  const DividerWithText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: AppDimensions.dividerThickness_2,
            indent: AppDimensions.padding_5,
            endIndent: AppDimensions.padding_5,
          ),
        ),
        Text(text, style: TextStyles.font16LightGrayMedium),
        Expanded(
          child: Divider(
            thickness: AppDimensions.dividerThickness_2,
            indent: AppDimensions.padding_5,
            endIndent: AppDimensions.padding_5,
          ),
        ),
      ],
    );
  }
}
