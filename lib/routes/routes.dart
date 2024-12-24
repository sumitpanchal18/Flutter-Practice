import 'package:flutter/material.dart';
import 'package:practice_flutter/Splash/SplashScreen.dart';
import 'package:practice_flutter/routes/routes_name.dart';
import 'package:practice_flutter/view/SignUp/SignupPage.dart';
import 'package:practice_flutter/view/internetCheck/ConnectivityCheckScreen.dart';
import 'package:practice_flutter/view/login/LoginPage.dart';

import '../view/HomePage.dart';
import '../view/forgotPass/ForgotPasswordPage.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomePage());
      case RouteName.forgotPassword:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ForgotPasswordPage());
      case RouteName.connectionChecker:
        return MaterialPageRoute(
            builder: (BuildContext context) => ConnectivityCheckScreen());
      case RouteName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());
      case RouteName.signUp:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignupPage());
      case RouteName.signIn:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginPage());
      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomePage());
    }
  }
}
