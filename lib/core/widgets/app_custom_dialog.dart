import 'package:clean_arch_riverpod/core/helper/extensions.dart';
import 'package:clean_arch_riverpod/core/helper/spacing.dart';
import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:clean_arch_riverpod/core/theming/text_styles.dart';
import 'package:flutter/material.dart';

class AppCustomDialog extends StatelessWidget {
  final String? title;
  final IconData? iconData;
  final String msg;
  final String okActionText;
  final String? cancelText;
  final VoidCallback okAction;
  final VoidCallback? cancelAction;
  const AppCustomDialog({
    super.key,
    this.title,
    this.iconData,
    required this.msg,
    required this.okActionText,
    this.cancelText,
    required this.okAction,
    this.cancelAction,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          !title.isNullOrEmpty
              ? Center(
                child: Text(title!, style: TextStyles.font15BlackSemiBold),
              )
              : null,

      content: Padding(
        padding: EdgeInsets.fromLTRB(
          AppDimensions.padding_5,
          AppDimensions.verticalPadding_10,
          AppDimensions.padding_5,
          0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (iconData != null) Icon(iconData),
            if (iconData != null) verticalSpace(AppDimensions.height_14),
            Text(msg, style: TextStyles.font14BlackRegular),
          ],
        ),
      ),
      actions: [
        if (cancelText != null && cancelAction != null)
          TextButton(
            onPressed: () => cancelAction!(),
            child: Text(cancelText!, style: TextStyles.font14DarckBlueMedium),
          ),
        ElevatedButton(
          onPressed: () => okAction(),
          child: Text(okActionText, style: TextStyles.font14DarckBlueMedium),
        ),
      ],
    );
  }

  static void show({
    required BuildContext context,
    String? title,
    IconData? icon,
    required String message,
    required VoidCallback okAction,
    required String okActionText,
    VoidCallback? cancelAction,
    String? cancelText,
  }) {
    showDialog(
      context: context,
      builder:
          (_) => AppCustomDialog(
            title: title,
            iconData: icon,
            msg: message,
            okAction: okAction,
            okActionText: okActionText,
            cancelAction: cancelAction,
            cancelText: cancelText,
          ),
    );
  }
}
