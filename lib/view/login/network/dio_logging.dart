import 'package:dio/dio.dart';

class DioLogging {
  static Dio createDio() {
    final dio = Dio();

    // Add built-in LogInterceptor
    dio.interceptors.add(LogInterceptor(
      request: true, // Log request data
      requestHeader: true, // Log request headers
      requestBody: true, // Log request body
      responseHeader: false, // Skip response headers
      responseBody: true, // Log response body
      error: true, // Log errors
    ));

    return dio;
  }
}
