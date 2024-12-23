import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  // Reactive state for loading
  var isLoading = false.obs;

  // Function to handle reset password logic
  Future<void> resetPassword(String email) async {
    try {
      isLoading.value = true;

      // Simulate API call for resetting password
      await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

      // Simulate success (you can replace this with actual API logic)
      print('Password reset link sent to: $email');

      // On success, show a message
      Get.snackbar('Success', 'Password reset link sent to $email');
    } catch (e) {
      // Handle error
      print('Error: $e');
      Get.snackbar('Error', 'Failed to send reset link');
    } finally {
      isLoading.value = false;
    }
  }
}
