import 'package:clean_arch_riverpod/core/theming/app_assets.dart';
import 'package:clean_arch_riverpod/featues/splash/presentation/splash_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreeen extends ConsumerWidget {
  const SplashScreeen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<bool>>(splashNotifierProvider, (previous, next) {
      next.whenOrNull(
        data: (isLoggedIn) {
          if (isLoggedIn) {
            // navigate to home screen
          } else {
            // navigate to login screen
          }
        },
        error: (error, stackTrace) {},
      );
    });
    return SafeArea(child: Center(child: Image.asset(AppAssets.imageDocLogo)));
  }
}
