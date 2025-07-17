import 'package:latlong2/latlong.dart';

class AppConsts {
  static const double screenWidth = 375;
  static const double screenHeigh = 812;
  static const int splashDelay = 2;
  static const double minPasswordLength = 8;
  static const double minNameLength = 3;
  static const int shimmerDoctorListCount = 5;
  static const int recomendedDocListCount = 3;
  static const int specialityListCount = 5;
  static const int specialityShimmerListCount = 5;
  static const int minSpecialityListLength = 3;
  static const int fakeSpecialityAllId = -1;
  static const int pagerTabLength = 3;
  static const double mapInitialZoom = 17;
  static const fakeDocLocationLatLng = LatLng(35.772795, 10.824776);
   static const ss ='MAPBOX_ACCESS_TOKEN';
  static const urlTemplate =
      'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/256/{z}/{x}/{y}@2x?access_token=';
   static const mapBoxEnvKey ='MAPBOX_ACCESS_TOKEN';
  static const userAgentPackageName = 'com.example.clean_arch_riverpod';
}
