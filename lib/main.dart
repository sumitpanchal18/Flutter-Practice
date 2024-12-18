import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:practice_flutter/Splash/SplashScreen.dart';
import 'package:practice_flutter/utills/MyRoutes.dart';
import 'Activity/HomePage.dart';
import 'Activity/LoginPage.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: MyRoutes.splashRoute,
      routes: {
        MyRoutes.homeRoute: (context) => const HomePage(),
        MyRoutes.loginRoute: (context) => const LoginPage(),
        MyRoutes.splashRoute: (context) => const SplashScreen(),
      },
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
