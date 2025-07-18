import 'package:clean_arch_riverpod/core/helper/extensions.dart';
import 'package:clean_arch_riverpod/core/theming/colors_manager.dart';
import 'package:clean_arch_riverpod/core/theming/text_styles.dart';
import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String message;
  const ErrorDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorsManager.white,
      content: Text(message, style: TextStyles.font14DarckBlueMedium),
      actions: [
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: Text(AppStrings.ok),
        ),
      ],
    );
  }

  static void show(BuildContext context, String message) {
    showDialog(context: context, builder: (_) => ErrorDialog(message: message));
  }
}
