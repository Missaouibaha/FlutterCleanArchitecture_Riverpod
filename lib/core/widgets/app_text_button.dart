import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:clean_arch_riverpod/core/theming/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextButton extends StatelessWidget {
  final String textButton;
  final TextStyle textStyle;
  final VoidCallback onPressed;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? buttonWidth;
  final double? buttonHeigh;
  final Color? backgroundColor;
  final double? borderRadius;
  const AppTextButton({
    super.key,
    required this.textButton,
    required this.textStyle,
    required this.onPressed,
    this.horizontalPadding,
    this.verticalPadding,
    this.buttonWidth,
    this.buttonHeigh,
    this.backgroundColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(
            horizontal: horizontalPadding?.w ?? AppDimensions.width_12,
            vertical: verticalPadding?.h ?? AppDimensions.height_14,
          ),
        ),
        fixedSize: WidgetStateProperty.all(
          Size(
            buttonWidth?.w ?? double.maxFinite,
            buttonHeigh?.h ?? AppDimensions.height_50,
          ),
        ),
        backgroundColor: WidgetStateProperty.all(
          backgroundColor ?? ColorsManager.mainBlue,
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              borderRadius ?? AppDimensions.radius_16,
            ),
          ),
        ),
      ),

      onPressed: onPressed,
      child: Text(textButton, style: textStyle),
    );
  }
}
