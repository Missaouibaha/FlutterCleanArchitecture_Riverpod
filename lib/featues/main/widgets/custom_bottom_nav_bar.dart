import 'package:clean_arch_riverpod/core/theming/app_assets.dart';
import 'package:clean_arch_riverpod/core/theming/colors_manager.dart';
import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return  BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: ColorsManager.white,
      currentIndex: currentIndex,
      onTap: onTap,
      unselectedItemColor: ColorsManager.darckBlue,
      selectedItemColor: ColorsManager.skyBlue,

      items: [
        BottomNavigationBarItem(
          label: AppStrings.homeLabel,
          icon:  ImageIcon(AssetImage(AppAssets.homeIcon)),
        ),
        BottomNavigationBarItem(
          label: AppStrings.chatLabel,
          icon: ImageIcon(AssetImage(AppAssets.chatIcon)),
        ),
        BottomNavigationBarItem(
          label: AppStrings.searchLabel,
          icon: ImageIcon(AssetImage(AppAssets.searchIcon)),
        ),
        BottomNavigationBarItem(
          label: AppStrings.appointmentLabel,
          icon: ImageIcon(AssetImage(AppAssets.appointmentIcon)),
        ),
        BottomNavigationBarItem(
          label: AppStrings.profileLabel,
          icon: Icon(Icons.person),
        ),
      ],
    );
  }
}
