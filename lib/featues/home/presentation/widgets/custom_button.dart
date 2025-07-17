import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String textButton;
  final TextStyle textStyle;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final double? maxWidth;

  const CustomButton({
    super.key,
    required this.textButton,
    required this.textStyle,
    required this.onPressed,
    required this.backgroundColor,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(AppDimensions.radius_8),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppDimensions.radius_8),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.padding_15,
            vertical: AppDimensions.verticalPadding_10,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxWidth ?? MediaQuery.of(context).size.width * 0.6,
            ),
            child: Text(
              textButton,
              style: textStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
          ),
        ),
      ),
    );
  }
}
