import 'package:clean_arch_riverpod/core/theming/text_styles.dart';
import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

class TermesConditionsView extends StatelessWidget {
  const TermesConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyles.font14LightGrayRegular,
          children: [
            TextSpan(text: AppStrings.termsAndconditionsSpan1),
            TextSpan(
              text: AppStrings.termsAndconditionsSpan2,
              style: TextStyles.font14DarckBlueMedium,
            ),
            TextSpan(text: AppStrings.termsAndconditionsSpan3),
            TextSpan(
              text: AppStrings.termsAndconditionsSpan4,
              style: TextStyles.font14DarckBlueMedium,
            ),
          ],
        ),
      ),
    );
  }
}
