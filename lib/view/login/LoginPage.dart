import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Import fluttertoast
import 'package:get/get.dart';
import 'package:practice_flutter/routes/routes_name.dart';

import 'controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final isPasswordVisible = false.obs; // Observable for password visibility
    final controller = Get.find<LoginController>();

    // Fetch screen dimensions for responsive design
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.08, // 8% of screen width
            vertical: screenHeight * 0.02, // 2% of screen height
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: screenHeight * 0.1), // 10% of screen height
              _header(),
              SizedBox(height: screenHeight * 0.05), // 5% of screen height
              Obx(() {
                return controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : _inputField(
                        context,
                        emailController,
                        passwordController,
                        screenWidth,
                        isPasswordVisible,
                      );
              }),
              SizedBox(height: screenHeight * 0.03), // 3% of screen height
              _forgotPassword(context),
              _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  _header() {
    return const Column(
      children: [
        Text(
          "Sign In",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  _inputField(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
    double screenWidth,
    RxBool isPasswordVisible,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            hintText: "Email",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.blue.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.email),
          ),
        ),
        SizedBox(height: screenWidth * 0.05), // 5% of screen width
        Obx(() {
          return TextField(
            controller: passwordController,
            obscureText: !isPasswordVisible.value, // Hide or show password
            decoration: InputDecoration(
              hintText: "Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.blue.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  isPasswordVisible.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: () {
                  isPasswordVisible.value = !isPasswordVisible.value;
                },
              ),
            ),
          );
        }),
        SizedBox(height: screenWidth * 0.04), // 4% of screen width
        ElevatedButton(
          onPressed: () {
            _loginWithFirebase(
                context, emailController.text, passwordController.text);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        )
      ],
    );
  }

  // Function to login using Firebase
  void _loginWithFirebase(
      BuildContext context, String email, String password) async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Show success toast
      Fluttertoast.showToast(
        msg: 'Login successful: ${userCredential.user?.email}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
      Navigator.pushReplacementNamed(context, RouteName.home);
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided.';
      }
      // Show error toast
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }

  _forgotPassword(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, RouteName.forgotPassword);
      },
      child: const Text(
        "Forgot password?",
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }

  _signup(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? "),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteName.signUp);
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.blue),
          ),
        )
      ],
    );
  }
}
