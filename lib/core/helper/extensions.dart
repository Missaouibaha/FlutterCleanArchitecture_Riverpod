import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension StringExtensions on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}

extension NavigationGoRouter on BuildContext {
  /// Navigate to a named route (replaces current screen)
  void goNamed(
    String routeName, {
    Map<String, String> params = const {},
    Object? extra,
  }) {
    GoRouter.of(this).goNamed(routeName, pathParameters: params, extra: extra);
  }

  /// Push a named route on top of current screen
  void pushNamed(
    String routeName, {
    Map<String, String> params = const {},
    Object? extra,
  }) {
    GoRouter.of(
      this,
    ).pushNamed(routeName, pathParameters: params, extra: extra);
  }

  /// Replace current screen with named route
  void pushReplacementNamed(
    String routeName, {
    Map<String, String> params = const {},
    Object? extra,
  }) {
    GoRouter.of(
      this,
    ).replaceNamed(routeName, pathParameters: params, extra: extra);
  }

  /// Pop current route
  void pop() => Navigator.of(this).pop();
}

extension NullableExtensions<T> on T? {
  R? let<R>(R Function(T it) block) {
    final self = this;
    if (self != null) {
      return block(self);
    }
    return null;
  }
}

extension Regex on String {
  String? isValidateEmail() {
    if (isEmpty) {
      return AppStrings.enterEmail;
    } else if (!RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(this)) {
      return AppStrings.enterValidEmail;
    }
    return null;
  }
}
