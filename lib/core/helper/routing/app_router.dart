import 'package:clean_arch_riverpod/core/helper/routing/navigator_observer.dart';
import 'package:clean_arch_riverpod/core/helper/routing/routes.dart';
import 'package:clean_arch_riverpod/core/theming/colors_manager.dart';
import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:clean_arch_riverpod/featues/details/presentation/details_screen.dart';
import 'package:clean_arch_riverpod/featues/home/domain/models/doctor_entity.dart';
import 'package:clean_arch_riverpod/featues/home/presentation/home_screen.dart';
import 'package:clean_arch_riverpod/featues/main/main_screen.dart';
import 'package:clean_arch_riverpod/featues/profile/presentation/profile_screen.dart';
import 'package:clean_arch_riverpod/featues/register/presentation/register_screen.dart';
import 'package:clean_arch_riverpod/featues/search/presentation/search_screen.dart';
import 'package:clean_arch_riverpod/featues/settings/presentation/settings_screen.dart';
import 'package:clean_arch_riverpod/featues/signin/presentation/sign_in_screen.dart';
import 'package:clean_arch_riverpod/featues/splash/presentation/splash_screeen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: Routes.splashScreen,
    observers: [LoggingNavigatorObserver()],
    routes: [
      GoRoute(
        name: Routes.splashScreen,
        path: Routes.splashScreen,
        builder: (context, state) => SplashScreeen(),
      ),
      GoRoute(
        name: Routes.loginScreen,
        path: Routes.loginScreen,
        builder: (context, state) => SignInScreen(),
      ),
      GoRoute(
        name: Routes.registerScreen,
        path: Routes.registerScreen,
        builder: (context, state) => RegisterScreen(),
      ),

      ShellRoute(
        builder: (context, state, child) {
          return MainScreen(child: child);
        },
        routes: [
          GoRoute(
            name: Routes.home,
            path: Routes.home,
            pageBuilder:
                (context, state) => NoTransitionPage(child: HomeScreen()),
          ),
          GoRoute(
            name: Routes.chat,
            path: Routes.chat,
            pageBuilder:
                (context, state) => NoTransitionPage(
                  child: const Scaffold(
                    body: Center(
                      child: Text(
                        AppStrings.chatLabel,
                        style: TextStyle(color: ColorsManager.skyBlue),
                      ),
                    ),
                    backgroundColor: ColorsManager.white,
                  ),
                ),
          ),
          GoRoute(
            name: Routes.search,
            path: Routes.search,
            pageBuilder:
                (context, state) => NoTransitionPage(child: SearchScreen()),
          ),
          GoRoute(
            name: Routes.appointment,
            path: Routes.appointment,
            pageBuilder:
                (context, state) => NoTransitionPage(
                  child: const Scaffold(
                    body: Center(
                      child: Text(
                        AppStrings.appointmentLabel,
                        style: TextStyle(color: ColorsManager.skyBlue),
                      ),
                    ),
                    backgroundColor: ColorsManager.white,
                  ),
                ),
          ),
          GoRoute(
            name: Routes.profile,
            path: Routes.profile,
            pageBuilder:
                (context, state) => NoTransitionPage(child: ProfileScreen()),
          ),
        ],
      ),

      GoRoute(
        name: Routes.settingsScreen,
        path: Routes.settingsScreen,
        builder: (context, state) => SettingsScreen(),
      ),
      GoRoute(
        name: Routes.detailsScreen,
        path: Routes.detailsScreen,
        builder: (context, state) {
          final doctor = state.extra as DoctorEntity;
          return (doctor != null)
              ? DetailsScreen(doctor: doctor)
              : HomeScreen();
        },
      ),
    ],
  );
});
