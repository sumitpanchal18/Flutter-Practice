import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../routes/routes_name.dart';

class SplashService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void checkAuthentication(BuildContext context) async {
    User? user = _auth.currentUser;

    if (user != null) {
      Navigator.pushReplacementNamed(context, RouteName.home);
    } else {
      Navigator.pushReplacementNamed(context, RouteName.home);
    }
  }
}
