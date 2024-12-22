import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:practice_flutter/routes/routes.dart';
import 'package:practice_flutter/routes/routes_name.dart';
import 'package:practice_flutter/view/login/controllers/ForgotPasswordController.dart';
import 'package:practice_flutter/view/login/controllers/login_controller.dart';
import 'package:practice_flutter/view/login/network/api_client.dart';
import 'package:practice_flutter/view/login/repository/login_repository.dart';

void main() {
  final apiClient = ApiClient();
  final loginRepository = LoginRepository(apiClient);
  Get.put(LoginController(loginRepository));
  Get.put(ForgotPasswordController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;
    return MaterialApp(
      title: 'Flutter',
      debugShowCheckedModeBanner: false,
      initialRoute: RouteName.splash,
      onGenerateRoute: Routes.generateRoute,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.blue,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}
