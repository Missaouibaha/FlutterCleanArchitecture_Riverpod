import 'package:clean_arch_riverpod/core/helper/extensions.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  DioFactory._();

  static Dio? dio;
  static getDio() {
    Duration timeOut = Duration(seconds: 25);
    if (dio == null) {
      dio = Dio();
      dio?.let((it) {
        it
          ..options.connectTimeout = timeOut
          ..options.receiveTimeout = timeOut;
      });
      addDioHeader();
      addDioInterceptor();
      return dio;
    } else {
      dio;
    }
  }

  static void addDioHeader() {
    dio?.options.headers = {'Accept': 'application/json'};
  }

  static void addDioInterceptor() {
    dio?.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ),
    );
  }
}
