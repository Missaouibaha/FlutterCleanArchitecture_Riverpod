import 'package:clean_arch_riverpod/core/helper/spacing.dart';
import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:clean_arch_riverpod/core/theming/text_styles.dart';
import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:clean_arch_riverpod/featues/home/presentation/widgets/home_top_bar.dart';
import 'package:clean_arch_riverpod/featues/home/presentation/widgets/recomendedDoctor/recomended_doctors_widget.dart';
import 'package:clean_arch_riverpod/featues/home/presentation/widgets/specialityWidget/speciality_list_widget.dart';
import 'package:clean_arch_riverpod/featues/home/presentation/widgets/top_card_view_doctor.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.verticalPadding_10,
            vertical: AppDimensions.padding_15,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                HomeTopBar(),
                verticalSpace(AppDimensions.height_35),
                TopCardViewDoctor(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.doctorSpeciality,
                      style: TextStyles.font15BlackSemiBold,
                    ),
                    Text(AppStrings.seeAll, style: TextStyles.font13BlueMedium),
                  ],
                ),
                verticalSpace(AppDimensions.height_8),
                SpecialityListWidget(),
                verticalSpace(AppDimensions.height_5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.recomendedDoctors,
                      style: TextStyles.font15BlackSemiBold,
                    ),
                    Text(AppStrings.seeAll, style: TextStyles.font13BlueMedium),
                  ],
                ),
                RecomendedDoctorsWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
