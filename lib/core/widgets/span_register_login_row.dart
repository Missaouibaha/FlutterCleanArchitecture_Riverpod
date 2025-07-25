import 'package:clean_arch_riverpod/core/helper/spacing.dart';
import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:clean_arch_riverpod/core/theming/text_styles.dart';
import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

class SpanRegisterLoginRow extends StatelessWidget {
  final VoidCallback navigateTo;
  final bool hasAnAcount;
  const SpanRegisterLoginRow({
    super.key,
    required this.navigateTo,
    required this.hasAnAcount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          hasAnAcount ? AppStrings.hvAccnt : AppStrings.hvntAccnt,
          style: TextStyles.font13BlackRegular,
        ),
        horizontalSpace(AppDimensions.width_3),
        GestureDetector(
          child: Text(
            hasAnAcount ? AppStrings.signIn : AppStrings.signUp,
            style: TextStyles.font13BlueMedium,
          ),
          onTap: () {
            navigateTo();
          },
        ),
      ],
    );
  }
}
