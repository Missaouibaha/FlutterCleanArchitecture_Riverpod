import 'package:clean_arch_riverpod/core/helper/spacing.dart';
import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:clean_arch_riverpod/core/theming/text_styles.dart';
import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:clean_arch_riverpod/featues/search/presentation/providers/doctor_notifier.dart';
import 'package:clean_arch_riverpod/featues/search/presentation/providers/refresh_data_provider.dart';
import 'package:clean_arch_riverpod/featues/search/presentation/widgets/doctor_list_widget.dart';
import 'package:clean_arch_riverpod/featues/search/presentation/widgets/filter_speciality_widget.dart';
import 'package:clean_arch_riverpod/featues/search/presentation/widgets/text_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchScreen extends ConsumerWidget {
  SearchScreen({super.key});

  TextEditingController searchController = TextEditingController(text: '');
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.read(refreshDataProvider.notifier).state = true;
            ref.invalidate(doctorNotifierProvider); 

          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.padding_5,
              vertical: AppDimensions.padding_10,
            ),
            child: Column(
              children: [
                Text(AppStrings.searchLabel, style: TextStyles.font24blackBold),
                verticalSpace(AppDimensions.height_20),
                TextSearchWidget(searchController: searchController),
                verticalSpace(AppDimensions.height_20),
                FilterSpecialityWidget(),
                verticalSpace(AppDimensions.height_40),
                Expanded(child: DoctorListWidget()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
