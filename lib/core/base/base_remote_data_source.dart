import 'package:clean_arch_riverpod/core/networking/api_error_handler.dart';
import 'package:clean_arch_riverpod/core/networking/api_result.dart';
import 'package:clean_arch_riverpod/core/networking/api_service.dart';
import 'package:flutter/foundation.dart';

class BaseRemoteDataSource {
  final ApiService? apiService;
  BaseRemoteDataSource({ this.apiService});

  Future<ApiResult<T>> safeApiCall<T>(Future<T> Function() apiCall) async {
    try {
      final result = await apiCall();
      return ApiResult.success(result);
    } catch (error) {
      debugPrint("❌ safeApiCall error: $error");
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
