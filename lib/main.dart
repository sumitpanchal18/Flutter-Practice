import 'package:flutter/material.dart';
import 'package:practice_flutter/Activity/AddContact.dart';
import 'package:practice_flutter/utills/ContactProvider.dart';
import 'package:practice_flutter/utills/MyRoutes.dart';
import 'package:provider/provider.dart';

import 'Activity/HomePage.dart';
import 'Activity/LoginPage.dart';
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ContactProvider(),
      child: const MaterialApp(
        home: HomePage(),
      ),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        "/": (context) => const HomePage(),
        MyRoutes.loginRoute: (context) => const LoginPage(),
        MyRoutes.contactRoute: (context) => const AddContact()
      },
      themeMode: ThemeMode.light,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueGrey[900],
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.blueGrey[700],
        ),
        scaffoldBackgroundColor: Colors.black,
      ),
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
