import 'package:flutter/material.dart';

class LoggingNavigatorObserver extends NavigatorObserver {
  final List<Route<dynamic>> _stack = [];

  List<String> get routeStack =>
      _stack.map((route) => route.settings.name ?? route.toString()).toList();

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _stack.add(route);
    debugPrint('Pushed: ${route.settings.name}');
    debugPrint('Stack now: $routeStack');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _stack.remove(route);
    debugPrint('Popped: ${route.settings.name}');
    debugPrint('Stack now: $routeStack');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _stack.remove(route);
    debugPrint('Removed: ${route.settings.name}');
    debugPrint('Stack now: $routeStack');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    final index = oldRoute != null ? _stack.indexOf(oldRoute) : -1;
    if (index >= 0 && newRoute != null) {
      _stack[index] = newRoute;
    }
    debugPrint(
      'Replaced: ${oldRoute?.settings.name} with ${newRoute?.settings.name}',
    );
    debugPrint('Stack now: $routeStack');
  }
}
