import 'package:flutter/material.dart';
import 'package:practice_flutter/Splash/SplashScreen.dart';
import 'package:practice_flutter/routes/routes_name.dart';
import 'package:practice_flutter/view/SignUp/SignupPage.dart';
import 'package:practice_flutter/view/login/LoginPage.dart';

import '../view/HomePage.dart';

class Routes {
  static Route<dynamic> genrateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomePage());
      case RouteName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());
      case RouteName.signUp:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignupPage());
      case RouteName.signIn:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoginPage());
      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomePage());
    }
  }
}
