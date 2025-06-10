import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:clean_arch_riverpod/core/theming/colors_manager.dart';
import 'package:clean_arch_riverpod/core/theming/text_styles.dart';
import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final TextEditingController? textController;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? errorBorder;
  final TextInputType? inputType;
  final TextStyle? inputTextStyle;
  final bool? isobscureText;
  final Widget? suffixIcon;
  final String? hint;
  final Color? filledColor;
  final TextStyle? hintStyle;
  final String? Function(String?)? validator;
  const AppTextFormField({
    super.key,
    this.textController,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.errorBorder,
    this.inputType,
    this.inputTextStyle,
    this.isobscureText,
    this.suffixIcon,
    required this.hint,
    this.filledColor,
    this.hintStyle,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController ?? TextEditingController(text: ''),
      style: inputTextStyle ?? TextStyles.font14DarckBlueMedium,
      obscureText: isobscureText ?? false,
      validator: validator,
      keyboardType: inputType ?? TextInputType.text,
      decoration: InputDecoration(
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
              horizontal: AppDimensions.width_20,
              vertical: AppDimensions.height_15,
            ),
        fillColor: filledColor ?? ColorsManager.ultraGray,
        isDense: true,
        filled: true,
        hintText: hint,
        hintStyle: hintStyle ?? TextStyles.font14LightGrayRegular,
        suffixIcon: suffixIcon,
        enabledBorder:
            enabledBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorsManager.extraLightGray,
                width: AppDimensions.width_1,
              ),
              borderRadius: BorderRadius.circular(AppDimensions.radius_16),
            ),
        focusedBorder:
            focusedBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorsManager.mainBlue,
                width: AppDimensions.width_1,
              ),
              borderRadius: BorderRadius.circular(AppDimensions.radius_16),
            ),
        errorBorder:
            errorBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorsManager.red,
                width: AppDimensions.width_1,
              ),
              borderRadius: BorderRadius.circular(AppDimensions.radius_16),
            ),
      ),
    );
  }
}
