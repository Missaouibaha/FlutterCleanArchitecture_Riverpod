import 'package:clean_arch_riverpod/core/helper/spacing.dart';
import 'package:clean_arch_riverpod/core/theming/app_assets.dart';
import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:clean_arch_riverpod/core/theming/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialLoginRow extends StatelessWidget {
  const SocialLoginRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialIcon(AppAssets.googleLogo),
        horizontalSpace(AppDimensions.width_30),
        _buildSocialIcon(AppAssets.facebookLogo),
        horizontalSpace(AppDimensions.width_30),
        _buildSocialIcon(AppAssets.iosLogo),
      ],
    );
  }

  Widget _buildSocialIcon(String assetPath) {
    return CircleAvatar(
      backgroundColor: ColorsManager.transparentGray,
      minRadius: AppDimensions.radius_30,
      child: SvgPicture.asset(
        assetPath,
        width: AppDimensions.width_40,
        height: AppDimensions.height_40,
      ),
    );
  }
}
