import 'package:clean_arch_riverpod/clean_arch_app.dart';
import 'package:clean_arch_riverpod/core/services/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final hiveService = HiveService();
  await hiveService.init();
   await dotenv.load(fileName: ".env");
   
  runApp(ProviderScope(child: CleanArchApp()));
}
