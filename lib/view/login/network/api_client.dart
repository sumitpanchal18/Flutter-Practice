import 'package:dio/dio.dart';

import 'dio_logging.dart';

class ApiClient {
  final Dio dio;

  ApiClient() : dio = DioLogging.createDio();

  Future<Response> post(String url,
      {required Map<String, dynamic> data,
      Map<String, String>? headers}) async {
    try {
      final response = await dio.post(
        url,
        data: data,
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to make API call: $e');
    }
  }
}
