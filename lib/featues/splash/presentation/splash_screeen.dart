import 'package:clean_arch_riverpod/core/helper/extensions.dart';
import 'package:clean_arch_riverpod/core/helper/routing/routes.dart';
import 'package:clean_arch_riverpod/core/theming/app_assets.dart';
import 'package:clean_arch_riverpod/core/theming/colors_manager.dart';
import 'package:clean_arch_riverpod/featues/splash/presentation/providers/splash_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreeen extends ConsumerWidget {
  const SplashScreeen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<bool>>(splashNotifierProvider, (previous, next) {
      next.whenOrNull(
        data: (isLoggedIn) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            isLoggedIn
                ? context.goNamed(Routes.home)
                : context.goNamed(Routes.loginScreen);
          });
        },
        error: (error, stackTrace) {},
      );
    });
    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: SafeArea(child: Center(child: Image.asset(AppAssets.imageDocLogo))),
    );
  }
}
