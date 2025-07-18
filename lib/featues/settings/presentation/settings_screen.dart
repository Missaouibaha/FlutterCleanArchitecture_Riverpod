import 'package:clean_arch_riverpod/core/helper/routing/routes.dart';
import 'package:clean_arch_riverpod/core/theming/colors_manager.dart';
import 'package:clean_arch_riverpod/core/theming/text_styles.dart';
import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:clean_arch_riverpod/core/widgets/app_custom_dialog.dart';
import 'package:clean_arch_riverpod/featues/settings/presentation/providers/settings_notifier.dart';
import 'package:clean_arch_riverpod/featues/settings/presentation/widgets/settings_option_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManager.lightBlueSky,
        title: Text(
          AppStrings.settingsLabel,
          style: TextStyles.font24blackBold,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: ColorsManager.black),
          onPressed: () => GoRouter.of(context).pop(),
        ),
      ),
      body: SettingsOptionList(
        onOptionClicked: (route) => _handleSettingOption(route, ref, context),
      ),
    );
  }

  void _handleSettingOption(
    String route,
    WidgetRef ref,
    BuildContext context,
  ) async {
    switch (route) {
      case Routes.logout:
        {
          AppCustomDialog.show(
            context: context,
            title: AppStrings.confirmLogout,
            message: AppStrings.askLogout,
            okAction: () async {
              try {
                final logoutNotifier = ref.read(
                  logoutNotifierProvider.notifier,
                );
                await logoutNotifier.logout();
              } catch (e) {
                // Error will be shown by LogoutStateListener
              }
            },
            okActionText: AppStrings.btnLogout,
            cancelText: AppStrings.cancel,
            cancelAction: () {},
          );

          break;
        }
    }
  }
}
