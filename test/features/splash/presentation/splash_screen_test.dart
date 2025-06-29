import 'package:clean_arch_riverpod/clean_arch_app.dart';
import 'package:clean_arch_riverpod/core/base/base_providers.dart';
import 'package:clean_arch_riverpod/core/helper/failure_model.dart';
import 'package:clean_arch_riverpod/core/helper/local/shared_preferences_keys.dart';
import 'package:clean_arch_riverpod/core/helper/routing/app_router.dart';
import 'package:clean_arch_riverpod/core/helper/routing/routes.dart';
import 'package:clean_arch_riverpod/core/networking/api_error_handler.dart';
import 'package:clean_arch_riverpod/featues/splash/presentation/splash_screeen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helper/test_utils.dart';

void main() {
  
  late MockSharedPreferencesHelper mockPrefs;

  late MockNavigatorObservor mockNavigator;
  late GoRouter testRouter;

  setUp(() {
    mockPrefs = MockSharedPreferencesHelper();
    mockNavigator = MockNavigatorObservor();
    registerFallbackValue(FakeRoute());
    testRouter = GoRouter(
      initialLocation: Routes.splashScreen,
      routes: [
        GoRoute(
          name: Routes.splashScreen,
          path: Routes.splashScreen,
          builder: (context, state) => const SplashScreeen(),
        ),
        GoRoute(
          name: Routes.mainScreen,
          path: Routes.mainScreen,
          builder: (context, state) => const Scaffold(body: Text('Main')),
        ),
        GoRoute(
          name: Routes.loginScreen,
          path: Routes.loginScreen,
          builder: (context, state) => const Scaffold(body: Text('Login')),
        ),
      ],
      observers: [mockNavigator],
    );
  });

  Future<void> _pumpSplashScreen(
    WidgetTester tester,
    ProviderContainer container,
  ) async {
    await tester.pumpWidget(
      UncontrolledProviderScope(container: container, child: CleanArchApp()),
    );
  }

  testWidgets('should navigate to main screen when user is connected', (
    widgetTester,
  ) async {
    // arrange
    when(
      () => mockPrefs.getValue(SharedPreferencesKeys.isConnected, false),
    ).thenAnswer((_) async => true);
    when(
      () => mockPrefs.getSecureString(SharedPreferencesKeys.token),
    ).thenAnswer((_) async => 'validToken');

    final container = ProviderContainer(
      overrides: [
        sharedPrefHelperProvider.overrideWith((ref) => mockPrefs),
        routerProvider.overrideWith((ref) => testRouter),
      ],
    );
    //act
    await _pumpSplashScreen(widgetTester, container);
    await widgetTester.pump(const Duration(seconds: 3));
    await widgetTester.pumpAndSettle();

    //assert
    verify(() => mockNavigator.didPush(any(), any())).called(greaterThan(0));
    expect(find.text('Main'), findsOneWidget);
  });
  testWidgets('should navigate to login screen when user is not connected', (
    widgetTester,
  ) async {
    when(
      () => mockPrefs.getValue(SharedPreferencesKeys.isConnected, false),
    ).thenAnswer((_) async => false);
    when(
      () => mockPrefs.getSecureString(SharedPreferencesKeys.token),
    ).thenAnswer((_) async => '');

    final container = ProviderContainer(
      overrides: [
        sharedPrefHelperProvider.overrideWith((ref) => mockPrefs),
        routerProvider.overrideWith((ref) => testRouter),
      ],
    );

    await _pumpSplashScreen(widgetTester, container);
    await widgetTester.pump(Duration(seconds: 3));
    await widgetTester.pumpAndSettle();

    verify(() => mockNavigator.didPush(any(), any())).called(greaterThan(0));
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('should navigate to login when local storage throws an exception(eg : cache error )', (
    widgetTester,
  ) async {
    final failure = Failure(ResponseMessage.CACHE_ERROR);
    //arrange
    when(
      () => mockPrefs.getValue(SharedPreferencesKeys.isConnected, false),
    ).thenThrow(failure);
    when(
      () => mockPrefs.getSecureString(SharedPreferencesKeys.token),
    ).thenThrow(failure);

    final container = ProviderContainer(
      overrides: [
        sharedPrefHelperProvider.overrideWith((ref) => mockPrefs),
        routerProvider.overrideWith((ref) => testRouter),
      ],
    );
    // act
    await _pumpSplashScreen(widgetTester, container);
    await widgetTester.pump(Duration(seconds: 3));
    await widgetTester.pumpAndSettle();

    //assert
    verify(() => mockNavigator.didPush(any(), any())).called(greaterThan(0));
    expect(find.text('Login'), findsOneWidget);
  });
}
