
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:practice_flutter/utills/constants/app_colors.dart';

class SvgProgressIndicator extends StatelessWidget {
  final String svgPath;
  final double size;
  final Color progressColor;
  final double strokeWidth;

  const SvgProgressIndicator({
    Key? key,
    required this.svgPath, // Path to the SVG asset
    this.size = 50.0, // Overall size of the widget
    this.progressColor = AppColors.primaryColor, // Default progress color
    this.strokeWidth = 4.0, // Thickness of the circular progress bar
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              strokeWidth: strokeWidth,
            ),
          ),
          SvgPicture.asset(
            svgPath,
            width: size * 0.74, // Adjust SVG size relative to the widget
            height: size * 0.74,
          ),
        ],
      ),
    );
  }
}
