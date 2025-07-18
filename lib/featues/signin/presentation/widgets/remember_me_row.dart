import 'package:clean_arch_riverpod/core/helper/spacing.dart';
import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:clean_arch_riverpod/core/theming/colors_manager.dart';
import 'package:clean_arch_riverpod/core/theming/text_styles.dart';
import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

class RememberMeRow extends StatelessWidget {
  final bool rememberMe;
  final ValueChanged<bool?> onRememberMeChanged;
  final VoidCallback onForgetPasswordPressed;
  const RememberMeRow({
    super.key,
    required this.rememberMe,
    required this.onRememberMeChanged,
    required this.onForgetPasswordPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: rememberMe,
              onChanged: onRememberMeChanged,
              activeColor: ColorsManager.blueAccent,
              checkColor: ColorsManager.black,
            ),
            Text(
              AppStrings.rememberMe,
              style: TextStyles.font16LightGrayMedium,
            ),
          ],
        ),
        horizontalSpace(AppDimensions.width_30),
        GestureDetector(
          onTap: onForgetPasswordPressed,
          child: Text(
            AppStrings.forgetPasswordMsg,
            style: TextStyles.font14BlueRegular,
          ),
        ),
      ],
    );
  }
}
