import '../gfmlm/ApiClient.dart';
import '../model/ApiEndpoints.dart';
import '../model/login_response_model.dart';

class LoginRepository {
  final ApiClient apiClient;

  LoginRepository(this.apiClient);

  Future<LoginDataResponse> login(String email, String password, String gRecaptchaResponse, bool rememberMe) async {
    // Prepare the data to match the API structure
    final data = {
      "email": email,
      "password": password,
      "gRecaptchaResponse": gRecaptchaResponse,
      "remember_me": rememberMe,
    };

    // Make the API call
    final response = await apiClient.post(ApiEndpoints.login, data: data);
    return LoginDataResponse.fromJson(response.data);
  }
}
