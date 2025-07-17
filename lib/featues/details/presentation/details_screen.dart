import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:clean_arch_riverpod/featues/details/presentation/widgets/pager/pager_details.dart';
import 'package:clean_arch_riverpod/featues/details/presentation/widgets/top_details_widget.dart';
import 'package:clean_arch_riverpod/featues/home/domain/models/doctor_entity.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final DoctorEntity doctor;
  const DetailsScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopDetailsWidget(doctor: doctor),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: AppDimensions.verticalPadding_2),
                child: PagerDetails(doctor: doctor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
