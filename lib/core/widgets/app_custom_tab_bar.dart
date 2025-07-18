import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:clean_arch_riverpod/core/theming/colors_manager.dart';
import 'package:clean_arch_riverpod/core/theming/text_styles.dart';
import 'package:flutter/material.dart';

class AppCustomTabBar extends StatelessWidget {
  final bool hasPrefixIcon;
  final bool hasSuffixIcon;
  final bool hasTitle;
  final Icon? suffixIcon;
  final Icon? prefixIcon;
  final String? title;
  final TextStyle? titleStyle;
  final VoidCallback? prefixCallBack;
  final VoidCallback? suffixCallBack;
  const AppCustomTabBar({
    super.key,
    required this.hasPrefixIcon,
    required this.hasSuffixIcon,
    required this.hasTitle,
    required this.suffixIcon,
    required this.prefixIcon,
    required this.title,
    required this.titleStyle,
    required this.prefixCallBack,
    required this.suffixCallBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppDimensions.padding_10,
        AppDimensions.verticalPadding_20,
        AppDimensions.padding_10,
        0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (hasPrefixIcon)
            GestureDetector(
              child:
                  prefixIcon ??
                  Icon(
                    Icons.arrow_back_ios,
                    size: AppDimensions.width_30,
                    color: ColorsManager.black,
                  ),
              onTap: () => prefixCallBack,
            ),
          if (hasTitle)
            Text(
              title ?? '',
              style: titleStyle ?? TextStyles.font20BlackSemiBold,
            ),
          if (hasSuffixIcon)
            GestureDetector(
              onTap: () => suffixCallBack,
              child:
                  suffixIcon ??
                  Icon(
                    Icons.settings,
                    size: AppDimensions.width_30,
                    color: ColorsManager.black,
                  ),
            ),
        ],
      ),
    );
  }
}
