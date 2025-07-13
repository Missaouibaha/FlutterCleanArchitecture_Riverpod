import 'package:clean_arch_riverpod/core/helper/routing/navigator_observer.dart';
import 'package:clean_arch_riverpod/core/helper/routing/routes.dart';
import 'package:clean_arch_riverpod/featues/main/main_screen.dart';
import 'package:clean_arch_riverpod/featues/register/presentation/register_screen.dart';
import 'package:clean_arch_riverpod/featues/settings/presentation/settings_screen.dart';
import 'package:clean_arch_riverpod/featues/signin/presentation/sign_in_screen.dart';
import 'package:clean_arch_riverpod/featues/splash/presentation/splash_screeen.dart';
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
      GoRoute(
        name: Routes.mainScreen,
        path: Routes.mainScreen,
        builder: (context, state) => MainScreen(),
      ),
      GoRoute(
        name: Routes.settingsScreen,
        path: Routes.settingsScreen,
        builder: (context, state) => SettingsScreen(),
      ),
    ],
  );
});
