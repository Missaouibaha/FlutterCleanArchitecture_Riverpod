import 'package:clean_arch_riverpod/core/helper/spacing.dart';
import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:clean_arch_riverpod/core/theming/colors_manager.dart';
import 'package:clean_arch_riverpod/core/theming/text_styles.dart';
import 'package:clean_arch_riverpod/core/widgets/error_dialog.dart';
import 'package:clean_arch_riverpod/featues/profile/presentation/providers/profile_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class UserDataWidget extends ConsumerWidget {
  const UserDataWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(profileNotifierProvider);
    return user.when(
      loading: () => _buildShimmer(),
      data: (profile) {
        return Center(
          child: Column(
            children: [
              Text("${profile?.name}", style: TextStyles.font24blackBold),
              Text("${profile?.email}", style: TextStyles.font20GraySemiBold),
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ErrorDialog.show(context, error.toString());
        });
        return _buildShimmer();
      },
    );
  }

  Shimmer _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: ColorsManager.grayShade300,
      highlightColor: ColorsManager.grayShade300,
      child: Center(
        child: Column(
          children: [
            shimmerItem(),
            verticalSpace(AppDimensions.height_10),
            shimmerItem(),
          ],
        ),
      ),
    );
  }

  Widget shimmerItem() {
    return Container(
      height: AppDimensions.height_25,
      width: AppDimensions.width_100,
      color: ColorsManager.lightBlue,
    );
  }
}
