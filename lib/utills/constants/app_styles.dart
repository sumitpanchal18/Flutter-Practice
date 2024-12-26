import 'package:flutter/material.dart';
import 'package:practice_flutter/utills/constants/dimens.dart';

import 'app_colors.dart';

class AppStyles {
  static const titleStyle = TextStyle(
    fontSize: Dimens.d20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const valueStyle = TextStyle(
    fontSize: Dimens.d14,
    color: AppColors.darkGrey,
  );

  static const subTitleStyle = TextStyle(
    fontSize: Dimens.d14,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const EdgeInsets padding = EdgeInsets.symmetric(vertical: Dimens.d8);

  static final ButtonStyle roundedButtonStyle = ElevatedButton.styleFrom(
    shape: const CircleBorder(),
    backgroundColor: AppColors.lightGrey,
    padding: const EdgeInsets.all(Dimens.d8),
  );
}

/*
SvgPicture.asset(
              'assets/images/web_icon.svg',
              width: 100,
              height: 100,
            ),
 */