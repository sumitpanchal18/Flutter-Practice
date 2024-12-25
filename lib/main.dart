import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:practice_flutter/routes/routes.dart';
import 'package:practice_flutter/routes/routes_name.dart';
import 'package:practice_flutter/view/login/controllers/ForgotPasswordController.dart';
import 'package:practice_flutter/view/login/controllers/login_controller.dart';
import 'package:practice_flutter/view/login/gfmlm/ApiClient.dart';
import 'package:practice_flutter/view/login/repository/login_repository.dart';
import 'package:practice_flutter/view/profile/DistributorController.dart';
import 'package:practice_flutter/view/profile/DistributorRepository.dart';

void main() async {
  final apiClient = ApiClient();

  // Login
  final loginRepository = LoginRepository(apiClient);
  Get.put(LoginController(loginRepository));

  final profileRepo = DistributorRepository();
  Get.put(DistributorController(repository: profileRepo));

  // Forgot Password
  Get.put(ForgotPasswordController());

  // Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
