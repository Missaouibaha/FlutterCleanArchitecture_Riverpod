import 'package:clean_arch_riverpod/core/theming/colors_manager.dart';
import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:clean_arch_riverpod/featues/home/presentation/home_screen.dart';
import 'package:clean_arch_riverpod/featues/main/providers/main_screen_index_provider.dart';
import 'package:clean_arch_riverpod/featues/main/widgets/custom_bottom_nav_bar.dart';
import 'package:clean_arch_riverpod/featues/search/presentation/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerWidget {
  final List<Widget> pages = [
    const HomeScreen(),

    const Scaffold(
      body: Center(
        child: Text(
          AppStrings.chatLabel,
          style: TextStyle(color: ColorsManager.skyBlue),
        ),
      ),
      backgroundColor: ColorsManager.white,
    ),
    Scaffold(body: SearchScreen(), backgroundColor: ColorsManager.white),

    const Scaffold(
      body: Center(
        child: Text(
          AppStrings.appointmentLabel,
          style: TextStyle(color: ColorsManager.skyBlue),
        ),
      ),
      backgroundColor: ColorsManager.white,
    ),
    const Scaffold(
      body: Center(
        child: Text(
          AppStrings.profileLabel,
          style: TextStyle(color: ColorsManager.skyBlue),
        ),
      ),
      backgroundColor: ColorsManager.white,
    ),
  ];

  MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(mainScreenIndexProvider);
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(mainScreenIndexProvider.notifier).state = index;
        },
      ),
    );
  }
}
