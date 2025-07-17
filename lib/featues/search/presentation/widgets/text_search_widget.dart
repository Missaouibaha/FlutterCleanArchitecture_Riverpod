import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:clean_arch_riverpod/core/theming/colors_manager.dart';
import 'package:clean_arch_riverpod/core/theming/text_styles.dart';
import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:clean_arch_riverpod/featues/search/presentation/providers/search_text_speciality_doctor_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextSearchWidget extends ConsumerWidget {
  final TextEditingController searchController;

  const TextSearchWidget({super.key, required this.searchController});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {
        return Padding(
          padding: EdgeInsets.all(AppDimensions.padding_8),
          child: TextFormField(
            style: TextStyles.font16BlackSemiBold,
            keyboardType: TextInputType.text,
            onChanged:
                (value) => ref.read(searchTextProvider.notifier).state = value,
            controller: searchController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(AppDimensions.padding_5),
              hintStyle: TextStyles.font17LightGreySemiBold,
              hintText: AppStrings.hintSearch,
              isDense: true,
              fillColor: ColorsManager.grayHint,
              filled: true,
              prefixIcon: Icon(Icons.search, size: AppDimensions.width_25),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(AppDimensions.radius_16),
              ),
            ),
          ),
        );
      },
    );
  }
}
