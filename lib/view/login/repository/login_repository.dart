import '../model/ApiEndpoints.dart';
import '../model/login_response_model.dart';
import '../network/api_client.dart';

class LoginRepository {
  final ApiClient apiClient;

  LoginRepository(this.apiClient);

  Future<LoginDataResponse> login(String email, String password) async {
    final data = {"email": email, "password": password};

    final response = await apiClient.post(ApiEndpoints.login, data: data);
    return LoginDataResponse.fromJson(response.data);
  }
}
