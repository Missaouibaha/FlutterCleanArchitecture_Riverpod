import 'package:clean_arch_riverpod/core/helper/routing/routes.dart';
import 'package:clean_arch_riverpod/core/theming/app_assets.dart';
import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:clean_arch_riverpod/core/theming/colors_manager.dart';
import 'package:clean_arch_riverpod/core/theming/text_styles.dart';
import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:clean_arch_riverpod/featues/settings/presentation/widgets/logout_state_listenner.dart';
import 'package:flutter/material.dart';

class SettingsOptionList extends StatelessWidget {
  final ValueChanged<String> onOptionClicked;
  const SettingsOptionList({super.key, required this.onOptionClicked});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppDimensions.height_30,
        horizontal: AppDimensions.padding_10,
      ),
      child: SafeArea(
        child: Column(
          children: [
            ..._buildSettingsTile(
              AppStrings.notification,
              AppAssets.notificationIcon,
              Routes.notifications,
            ),
            LogoutStateListener(),
            ..._buildSettingsTile(
              AppStrings.faq,
              AppAssets.faqIcon,
              Routes.faq,
            ),
            ..._buildSettingsTile(
              AppStrings.security,
              AppAssets.securityIcon,
              Routes.security,
            ),
            ..._buildSettingsTile(
              AppStrings.language,
              AppAssets.languageIcon,
              Routes.language,
            ),
            ..._buildSettingsTile(
              AppStrings.logout,
              AppAssets.logoutIcon,
              Routes.logout,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSettingsTile(String title, String iconPath, String route) {
    return [
      ListTile(
        title: Text(title, style: TextStyles.font14BlackRegular),
        leading: Image.asset(iconPath),
        trailing: Icon(Icons.arrow_forward_ios, color: ColorsManager.black),
        onTap: () {
          onOptionClicked(route);
        },
      ),
      Divider(
        color: ColorsManager.grayShade300,
        indent: AppDimensions.padding_10,
        endIndent: AppDimensions.padding_10,
        thickness: AppDimensions.height_1,
        height: AppDimensions.height_1,
      ),
    ];
  }
}
