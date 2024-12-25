import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:practice_flutter/routes/routes_name.dart';

import '../model/login_response_model.dart';
import '../network/headers_manager.dart';
import '../repository/login_repository.dart';

class LoginController extends GetxController {
  final LoginRepository repository;

  var isLoading = false.obs;
  var loginMessage = ''.obs;

  LoginController(this.repository);

  Future<void> login(BuildContext context, String email, String password,
      String gRecaptchaResponse, bool rememberMe) async {
    isLoading.value = true;
    loginMessage.value = '';

    try {
      final LoginDataResponse response = await repository.login(
          email, password, gRecaptchaResponse, rememberMe);

      if (response.status == 200) {
        final result = response.result;

        if (result != null && result.headerToken != null) {
          await HeadersManager.saveToken(result.headerToken!);
        }
        loginMessage.value = response.message ?? "Login successful!";
        Get.snackbar("hurry..!", "Login successful!");
        Navigator.pushReplacementNamed(context, RouteName.home);
      } else {
        loginMessage.value = response.message ?? "Login failed!";
        Get.snackbar("Error", loginMessage.value);
      }
    } catch (e) {
      loginMessage.value = "Something went wrong. Please try again.";
      Get.snackbar("Error", loginMessage.value);
    } finally {
      isLoading.value = false;
    }
  }
}
