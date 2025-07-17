import 'package:clean_arch_riverpod/core/helper/spacing.dart';
import 'package:clean_arch_riverpod/core/theming/app_assets.dart';
import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:clean_arch_riverpod/core/theming/text_styles.dart';
import 'package:clean_arch_riverpod/core/utils/app_consts.dart';
import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:clean_arch_riverpod/featues/home/domain/models/doctor_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';

class LocationPage extends StatelessWidget {
  final DoctorEntity doctor;
  const LocationPage({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.padding_10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            verticalSpace(AppDimensions.height_30),
            Text(
              AppStrings.practicePlace,
              style: TextStyles.font20BlueSemiBold,
            ),
            verticalSpace(AppDimensions.height_15),
            Text("${doctor?.address} ", style: TextStyles.font17BlackSemiBold),
            verticalSpace(AppDimensions.height_15),
            Text(AppStrings.locationMap, style: TextStyles.font20BlueSemiBold),
            verticalSpace(AppDimensions.height_15),

            Container(
              width: double.infinity,
              height: AppDimensions.height_250,
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: AppConsts.fakeDocLocationLatLng,
                  initialZoom: AppConsts.mapInitialZoom,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        '${AppConsts.urlTemplate}${dotenv.env[AppConsts.mapBoxEnvKey]}',
                    userAgentPackageName: AppConsts.userAgentPackageName,
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        height: AppDimensions.height_50,
                        width: AppDimensions.width_50,
                        point: AppConsts.fakeDocLocationLatLng,
                        child: Image.asset(AppAssets.iconMarker),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
