import 'package:clean_arch_riverpod/core/helper/extensions.dart';
import 'package:clean_arch_riverpod/core/helper/routing/routes.dart';
import 'package:clean_arch_riverpod/core/helper/spacing.dart';
import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:clean_arch_riverpod/core/theming/colors_manager.dart';
import 'package:clean_arch_riverpod/core/theming/text_styles.dart';
import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:clean_arch_riverpod/featues/profile/presentation/widgets/appointments_records_widget.dart';
import 'package:clean_arch_riverpod/featues/profile/presentation/widgets/profile_information_list.dart';
import 'package:clean_arch_riverpod/featues/profile/presentation/widgets/rounded_photo_widget.dart';
import 'package:clean_arch_riverpod/featues/profile/presentation/widgets/user_data_widget.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.blueAccent,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            AppDimensions.padding_2,
            AppDimensions.verticalPadding_8,
            AppDimensions.padding_2,
            0,
          ),
          child: Column(
            children: [
              AppBar(
                backgroundColor: ColorsManager.blueAccent,
                title: Text(
                  AppStrings.profileLabel,
                  style: TextStyles.font25WhiteSemiBold,
                ),
                centerTitle: true,
                actions: [
                  GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        0,
                        AppDimensions.verticalPadding_5,
                        AppDimensions.padding_8,
                        AppDimensions.verticalPadding_5,
                      ),
                      child: Icon(
                        Icons.settings,
                        size: AppDimensions.width_28,
                        color: ColorsManager.white,
                      ),
                    ),
                    onTap: () {
                      context.pushNamed(Routes.settingsScreen);
                    },
                  ),
                ],
              ),

              verticalSpace(AppDimensions.height_140),

              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        SingleChildScrollView(
                          child: Container(
                            height: constraints.maxHeight,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                  AppDimensions.radius_12,
                                ),
                                topRight: Radius.circular(
                                  AppDimensions.radius_12,
                                ),
                              ),
                              color: ColorsManager.white,
                            ),
                            child: Column(
                              children: [
                                verticalSpace(AppDimensions.height_75),
                                UserDataWidget(),
                                verticalSpace(AppDimensions.height_20),
                                AppointmentsRecordsWidget(),
                                verticalSpace(AppDimensions.height_25),
                                ProfileInformationList(),
                              ],
                            ),
                          ),
                        ),

                        Positioned(
                          top: -AppDimensions.height_75,
                          right: 0,
                          left: 0,
                          child: Center(child: RoundedPhotoWidget()),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
