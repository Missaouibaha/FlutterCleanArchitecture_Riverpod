import 'package:clean_arch_riverpod/core/helper/spacing.dart';
import 'package:clean_arch_riverpod/core/theming/app_assets.dart';
import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:clean_arch_riverpod/core/theming/colors_manager.dart';
import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

class ProfileInformationList extends StatelessWidget {
  const ProfileInformationList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...buildListTileSection(
          title: AppStrings.personalInfo,
          iconPath: AppAssets.personalInfoIcon,
          iconColor: ColorsManager.skyBlue,
          backgroundColor: ColorsManager.extraLightBlue,
          isLastItem: false,
        ),
        ...buildListTileSection(
          title: AppStrings.testAndDiagnostic,
          iconPath: AppAssets.diagnosticIcon,
          iconColor: ColorsManager.green,
          backgroundColor: ColorsManager.lightGreen,
          isLastItem: false,
        ),
        ...buildListTileSection(
          title: AppStrings.payment,
          iconPath: AppAssets.walletIcon,
          iconColor: ColorsManager.pink,
          backgroundColor: ColorsManager.lightPink,
          isLastItem: true,
        ),
      ],
    );
  }

  List<Widget> buildListTileSection({
    required String title,
    required String iconPath,
    required Color backgroundColor,
    required Color iconColor,
    required bool isLastItem,
  }) {
    return [
      ListTile(
        title: Text(title),
        leading: CircleAvatar(
          backgroundColor: backgroundColor,
          child: Padding(
            padding: EdgeInsets.all(AppDimensions.padding_5),
            child: Image.asset(iconPath, color: iconColor),
          ),
        ),
      ),

      if (!isLastItem) ...[
        verticalSpace(AppDimensions.height_5),
        Divider(
          color: ColorsManager.grayShade300,
          height: AppDimensions.height_10,
          thickness: AppDimensions.width_1,
          endIndent: AppDimensions.padding_10,
          indent: AppDimensions.padding_10,
        ),
        verticalSpace(AppDimensions.height_5),
      ],
    ];
  }
}
