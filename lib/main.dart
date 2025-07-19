import 'package:clean_arch_riverpod/clean_arch_app.dart';
import 'package:clean_arch_riverpod/core/services/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final hiveService = HiveService();
  await hiveService.init();
  // To use Mapbox, create an `.env` file, store the access token in it, and load it using:
  //await dotenv.load(fileName: AppConsts.envExt);
  runApp(ProviderScope(child: CleanArchApp()));
}
