import 'package:clean_arch_riverpod/core/helper/spacing.dart';
import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:clean_arch_riverpod/core/theming/colors_manager.dart';
import 'package:clean_arch_riverpod/core/theming/text_styles.dart';
import 'package:flutter/material.dart';

class AppCustomDialog extends StatefulWidget {
  final String? title;
  final IconData? iconData;
  final String msg;
  final String okActionText;
  final String? cancelText;
  final Future<void> Function() okAction;
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

  static Future<void> show({
    required BuildContext context,
    String? title,
    IconData? icon,
    required String message,
    required Future<void> Function() okAction,
    required String okActionText,
    VoidCallback? cancelAction,
    String? cancelText,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
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

  @override
  State<AppCustomDialog> createState() => _AppCustomDialogState();
}

class _AppCustomDialogState extends State<AppCustomDialog> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorsManager.white,
      title:
          widget.title != null && widget.title!.isNotEmpty
              ? Center(
                child: Text(
                  widget.title!,
                  style: TextStyles.font15BlueSemiBold,
                ),
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
            if (widget.iconData != null) Icon(widget.iconData),
            if (widget.iconData != null) verticalSpace(AppDimensions.height_14),
            Text(widget.msg, style: TextStyles.font14BlackRegular),
          ],
        ),
      ),
      actions: [
        if (widget.cancelText != null && widget.cancelAction != null)
          TextButton(
            onPressed:
                _isLoading
                    ? null
                    : () {
                      Navigator.of(context).pop();
                      widget.cancelAction!();
                    },
            child: Text(
              widget.cancelText!,
              style: TextStyles.font14UnderlineDarckBlueMedium,
            ),
          ),
        ElevatedButton(
          onPressed:
              _isLoading
                  ? null
                  : () async {
                    setState(() => _isLoading = true);
                    try {
                      await widget.okAction();
                      if (!mounted) return;
                      Navigator.of(context).pop();
                    } catch (e) {
                      if (!mounted) return;
                      Navigator.of(context).pop();
                    } finally {
                      if (mounted) setState(() => _isLoading = false);
                    }
                  },
          child:
              _isLoading
                  ? SizedBox(
                    width: AppDimensions.width_20,
                    height: AppDimensions.height_20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                  : Text(
                    widget.okActionText,
                    style: TextStyles.font14DarckBlueMedium,
                  ),
        ),
      ],
    );
  }
}
