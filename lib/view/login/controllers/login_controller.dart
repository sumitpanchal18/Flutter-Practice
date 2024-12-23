import 'package:get/get.dart';

import '../model/login_response_model.dart';
import '../network/headers_manager.dart';
import '../repository/login_repository.dart';

class LoginController extends GetxController {
  final LoginRepository repository;

  // Observable variables for state management
  var isLoading = false.obs;
  var loginMessage = ''.obs;

  LoginController(this.repository);

  /// Login function
  Future<void> login(String email, String password) async {
    isLoading.value = true;
    loginMessage.value = '';

    try {
      // Call login API
      final LoginDataResponse response =
          (await repository.login(email, password));

      // Check the response status
      if (response.status == 200) {
        final result = response.result;

        // Save header token globally using HeadersManager
        if (result != null && result.headerToken != null) {
          await HeadersManager.saveToken(result.headerToken!);
        }

        // Navigate to Home screen on success
        loginMessage.value = response.message ?? "Login successful!";
        Get.snackbar("hurrey..!", "Login successful!");
        Get.offNamed('/home');
      } else {
        // Show error message if login failed
        loginMessage.value = response.message ?? "Login failed!";
        Get.snackbar("Error", loginMessage.value);
      }
    } catch (e) {
      // Handle errors and update the login message
      loginMessage.value = "Something went wrong. Please try again.";
      Get.snackbar("Error", loginMessage.value);
    } finally {
      isLoading.value = false;
    }
  }
}
