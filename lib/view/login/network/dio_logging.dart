import 'package:dio/dio.dart';

class DioLogging {
  static Dio createDio() {
    final dio = Dio();

    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
      error: true,
    ));

    return dio;
  }
}
