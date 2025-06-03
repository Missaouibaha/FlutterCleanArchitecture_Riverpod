import 'package:clean_arch_riverpod/core/helper/routing/routes.dart';
import 'package:clean_arch_riverpod/featues/splash/splash_screeen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: Routes.splashScreen,
    routes: [
      GoRoute(
        name: Routes.splashScreen,
        path: Routes.splashScreen,
        builder: (context, state) => SplashScreeen(),
      ),
    ],
  );
});
