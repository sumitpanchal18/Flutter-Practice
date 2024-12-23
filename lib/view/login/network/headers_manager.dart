import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HeadersManager {
  static const _storage = FlutterSecureStorage();
  static const _authTokenKey = "authToken";

  static Future<Map<String, String>> getHeaders() async {
    final token = await _storage.read(key: _authTokenKey);
    return {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": token != null ? "Bearer $token" : "",
      "device-token": "eeRGGWKwSWa3E-JXvGNHbf:APA91bFiHTI63Atfu8BTZccXztqX9DE-kcuU8Tln0KXB31Kv6ti5BQ-FI9D5-tJ-no4QgiHBT50HAvJLigq2oewUZOAQivsfY1VASoWrOgx7-Q2oAIOvrag",
      "device-type": "2",
      "version-number": "1.0.2",
      "is-mobile": "1",
    };
  }

  static Future<void> saveToken(String token) async {
    await _storage.write(key: _authTokenKey, value: token);
  }
}
