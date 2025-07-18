import 'package:clean_arch_riverpod/core/helper/routing/app_router.dart';
import 'package:clean_arch_riverpod/core/theming/colors_manager.dart';
import 'package:clean_arch_riverpod/core/utils/app_consts.dart';
import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CleanArchApp extends ConsumerWidget {
  const CleanArchApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return ScreenUtilInit(
      designSize: Size(AppConsts.screenWidth, AppConsts.screenHeigh),
      minTextAdapt: true,
      child: MaterialApp.router(
        title: AppStrings.appName,
        theme: ThemeData(
          scaffoldBackgroundColor: ColorsManager.white,
          primaryColor: ColorsManager.blueAccent,
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
