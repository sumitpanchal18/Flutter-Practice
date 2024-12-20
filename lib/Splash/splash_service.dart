import 'package:flutter/cupertino.dart';

import '../routes/routes_name.dart';

class SplashService {
  void checkAuthentication(BuildContext context) async {
    Navigator.pushReplacementNamed(context, RouteName.signIn);
  }
}
