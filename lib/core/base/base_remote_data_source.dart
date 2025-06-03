import 'package:clean_arch_riverpod/core/networking/api_service.dart';

class BaseRemoteDataSource {
  final ApiService? apiService;
  BaseRemoteDataSource(this.apiService);
}
