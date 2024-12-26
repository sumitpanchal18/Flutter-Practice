import 'dart:async';

import 'package:flutter/material.dart';
import 'package:practice_flutter/Splash/splash_service.dart';
import 'package:practice_flutter/utills/constants/app_colors.dart';

import '../utills/size_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashService splashService = SplashService();

  @override
  void initState() {
    super.initState();
    // Future.delayed(const Duration(seconds: 5), () {
    //   splashService.checkAuthentication(context);
    // });
    Timer(const Duration(seconds: 5), () {
      splashService.checkAuthentication(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.flash_on,
              size: 200,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            Text(
              "Flutter",
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
