import 'package:clean_arch_riverpod/core/helper/routing/routes.dart';
import 'package:clean_arch_riverpod/featues/main/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends ConsumerWidget {
  final Widget child;

  const MainScreen({super.key, required this.child});

  static const _tabs = [
    Routes.home,
    Routes.chat,
    Routes.search,
    Routes.appointment,
    Routes.profile,
  ];

  int _getTabIndexFromLocation(String location) {
    final index = _tabs.indexWhere((tab) => location.startsWith(tab));
    return index < 0 ? 0 : index;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location =
        GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString();
    final currentIndex = _getTabIndexFromLocation(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          if (index != currentIndex) {
            context.goNamed(_tabs[index]);
          }
        },
      ),
    );
  }
}
