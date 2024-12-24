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
    final isPasswordVisible = false.obs;
    final controller = Get.find<LoginController>();

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.08,
              vertical: screenHeight * 0.02,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: screenHeight * 0.1),
                _header(),
                SizedBox(height: screenHeight * 0.05),
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
                SizedBox(height: screenHeight * 0.03),
                _forgotPassword(context),
                _signup(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
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

  Widget _inputField(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
    double screenWidth,
    RxBool isPasswordVisible,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTextField(
          controller: emailController,
          hintText: "Email",
          icon: Icons.email,
        ),
        SizedBox(height: screenWidth * 0.05),
        _buildTextField(
          controller: passwordController,
          hintText: "Password",
          icon: Icons.lock,
          obscureText: !isPasswordVisible.value,
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              isPasswordVisible.value = !isPasswordVisible.value;
            },
          ),
        ),
        SizedBox(height: screenWidth * 0.06),
        _loginButton(context, emailController, passwordController),
        SizedBox(height: screenWidth * 0.02),
        const Center(child: Text("Or")),
        SizedBox(height: screenWidth * 0.02),
        _googleSignInButton(),
      ],
    );
  }

  // Helper method to build text fields
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        fillColor: Colors.blue.withOpacity(0.1),
        filled: true,
        prefixIcon: Icon(icon),
        suffixIcon: suffixIcon,
      ),
    );
  }

  // Login button widget
  Widget _loginButton(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) {
    return ElevatedButton(
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
    );
  }

  // Google Sign-In Button widget
  Widget _googleSignInButton() {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.blue),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: TextButton(
        onPressed: () {
          // Google sign-in logic here
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 30.0,
              width: 30.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/google.png'),
                    fit: BoxFit.cover),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 18),
            const Text(
              "Sign In with Google",
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Forgot password link widget
  Widget _forgotPassword(BuildContext context) {
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

  // Sign up link widget
  Widget _signup(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?"),
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

  // Firebase login logic
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
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }
}
