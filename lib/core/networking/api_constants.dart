import 'package:clean_arch_riverpod/core/utils/app_strings.dart';

class ApiConstants {
  static const String baseUrl = "https://vcare.integration25.com/api/";
  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String profile = "user/profile";
  static const String home = "home/index";
  static const String doctor = "doctor/index";
}

class ApiErrors {
  static const String badRequestError = AppStrings.badRequestError;
  static const String noContent = AppStrings.noContentError;
  static const String forbiddenError = AppStrings.forbiddenError;
  static const String unauthorizedError = AppStrings.unauthorizedError;
  static const String notFoundError = AppStrings.notFoundError;
  static const String conflictError = AppStrings.conflictError;
  static const String internalServerError = AppStrings.internalServerError;
  static const String unknownError = AppStrings.unexpectedError;
  static const String timeoutError = AppStrings.timeoutError;
  static const String defaultError = AppStrings.defaultError;
  static const String cacheError = AppStrings.cacheError;
  static const String noInternetError = AppStrings.noInternetError;
  static const String loadingMessage = AppStrings.loadingMessage;
  static const String retryAgainMessage = AppStrings.retryAgainMessage;
}
