import 'package:clean_arch_riverpod/core/helper/enums/gender.dart';
import 'package:clean_arch_riverpod/core/theming/text_styles.dart';
import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:clean_arch_riverpod/featues/register/presentation/providers/genderProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GenderWidget extends StatelessWidget {
  const GenderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final currentGender = ref.watch(genderProvider);

        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(AppStrings.gender, style: TextStyles.font14DarckBlueMedium),
            _generateCheckbox(ref, currentGender, Gender.male),
            Text(Gender.male.genderName, style: TextStyles.font13BlackRegular),
            _generateCheckbox(ref, currentGender, Gender.female),
            Text(
              Gender.female.genderName,
              style: TextStyles.font13BlackRegular,
            ),
          ],
        );
      },
    );
  }

  Checkbox _generateCheckbox(
    WidgetRef ref,
    Gender? currentGender,
    Gender selectedGender,
  ) {
    return Checkbox(
      value: currentGender == selectedGender,
      onChanged: (value) {
        if (value == true) {
          ref.read(genderProvider.notifier).state = selectedGender;
        }
      },
    );
  }
}
