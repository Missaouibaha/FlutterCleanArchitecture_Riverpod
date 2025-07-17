import 'package:clean_arch_riverpod/core/helper/extensions.dart';
import 'package:clean_arch_riverpod/core/helper/routing/routes.dart';
import 'package:clean_arch_riverpod/core/widgets/loading_indicator.dart';
import 'package:clean_arch_riverpod/featues/settings/presentation/providers/settings_notifier.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogoutStateListener extends ConsumerWidget {
  const LogoutStateListener({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<bool>>(logoutNotifierProvider, (previous, next) {
      if (previous == next) return;

      next.when(
        data: (value) {
          LoadingIndicator.hide(context);
          if (value) {
            context.goNamed(Routes.loginScreen);
          }
        },
        error: (e, st) {
          LoadingIndicator.hide(context);
        },
        loading: () {
          LoadingIndicator.show(context);
        },
      );
    });

    return const SizedBox.shrink();
  }
}
