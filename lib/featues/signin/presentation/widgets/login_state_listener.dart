import 'package:clean_arch_riverpod/core/helper/extensions.dart';
import 'package:clean_arch_riverpod/core/helper/routing/routes.dart';
import 'package:clean_arch_riverpod/core/widgets/error_dialog.dart';
import 'package:clean_arch_riverpod/core/widgets/loading_indicator.dart';
import 'package:clean_arch_riverpod/featues/signin/domain/entities/user.dart';
import 'package:clean_arch_riverpod/featues/signin/presentation/providers/login_notifier.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginStateListener extends ConsumerWidget {
  const LoginStateListener({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<User?>>(loginNotifierProvider, (previous, next) {
      next.when(
        loading: () {
          LoadingIndicator.show(context);
        },

        data: (user) {
          if (user != null) {
            LoadingIndicator.hide(context);
            context.goNamed(Routes.home, extra: {'resetIndex': true});
          }
        },
        error: (error, stackTrace) {
          LoadingIndicator.hide(context);
          ErrorDialog.show(context, error.toString());
        },
      );
    });
    return const SizedBox.shrink();
  }
}
