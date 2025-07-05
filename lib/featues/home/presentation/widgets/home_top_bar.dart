import 'package:clean_arch_riverpod/core/helper/spacing.dart';
import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:clean_arch_riverpod/core/theming/colors_manager.dart';
import 'package:clean_arch_riverpod/core/theming/text_styles.dart';
import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:clean_arch_riverpod/featues/home/presentation/providers/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeTopBar extends ConsumerWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userNotifierProvider).asData?.value;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${AppStrings.hiMsg} ${user?.name ?? ''}",
              style: TextStyles.font17BlackSemiBold,
            ),
            verticalSpace(AppDimensions.height_8),
            Text(AppStrings.welcomeHomeMsg, style: TextStyles.font13GreyLight),
          ],
        ),
        GestureDetector(
          child: GestureDetector(
            onTap: () {},
            child: CircleAvatar(
              backgroundColor: ColorsManager.gray,
              child: Icon(Icons.notifications),
            ),
          ),
        ),
      ],
    );
  }
}
