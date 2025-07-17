import 'package:clean_arch_riverpod/core/helper/extensions.dart';
import 'package:clean_arch_riverpod/core/helper/routing/routes.dart';
import 'package:clean_arch_riverpod/core/widgets/error_dialog.dart';
import 'package:clean_arch_riverpod/core/widgets/loading_indicator.dart';
import 'package:clean_arch_riverpod/featues/register/presentation/providers/register_notifier.dart';
import 'package:clean_arch_riverpod/featues/signin/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterStateListener extends ConsumerWidget {
  const RegisterStateListener({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<User?>>(registerNotifierProvider, (previous, next) {
      next.when(
        loading: () {
          LoadingIndicator.show(context);
        },
        data: (user) {
          if (user != null) {
            LoadingIndicator.hide(context);
            context.pushNamed(Routes.home);
          }
        },
        error: (error, stackTrace) {
          LoadingIndicator.hide(context);
          ErrorDialog.show(context, error.toString());
        },
      );
    });
    return SizedBox.shrink();
  }
}
