import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/ForgotPasswordController.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final controller =
        Get.find<ForgotPasswordController>(); // Get the controller

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Forgot Password'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _header(context),
              const SizedBox(height: 50),
              _inputField(context, emailController, controller),
            ],
          ),
        ),
      ),
    );
  }

  _header(BuildContext context) {
    return const Column(
      children: [
        Text(
          "Reset Your Password",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  _inputField(
    BuildContext context,
    TextEditingController emailController,
    ForgotPasswordController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            hintText: "Enter your email",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: Colors.blue.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.email),
          ),
        ),
        const SizedBox(height: 26),
        ElevatedButton(
          onPressed: () {
            // Call the reset password function from controller
            controller.resetPassword(emailController.text);
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.blue,
          ),
          child: const Text(
            "Send Reset Link",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        const SizedBox(height: 30),
        _backToLogin(context),
      ],
    );
  }

  _backToLogin(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Navigate back to the Login page
        Navigator.pop(context);
      },
      child: const Text(
        "Back to Login",
        style: TextStyle(color: Colors.blue, fontSize: 16),
      ),
    );
  }
}
