import 'package:dio/dio.dart';

class DistributorRepository {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> fetchDistributorData() async {
    final response = await _dio.get(
      'https://dz9cg9nxtc.execute-api.us-east-1.amazonaws.com/distributors/',
      options: Options(
        headers: {
          'accept': '*/*',
          'Authorization':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbkRhdGEiOnsidW5pcXVlX2NvZGUiOjY2Mzg3NDI4LCJ1c2VyX2lkIjoiNjczYzZkY2RjY2Y3NDRkMjBlYTk3ZWIyIiwiaXNfZGlzdHJpYnV0b3IiOnRydWUsImRpc3RyaWJ1dG9yIjoiNjczYzZkY2FjY2Y3NDRkMjBlYTk3ZWFjIn0sImlhdCI6MTczNTIwODczMiwiZXhwIjoxNzM1Mjk1MTMyfQ.4q3eZ8Ah_GX-cI7oIxLbsq4uiiZBcm044eJcM5AFGXM',
          'x-clientid': '66387428',
        },
      ),
    );

    print('API Response: ${response.data}');

    return response.data;
  }
}
