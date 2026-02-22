import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryAccent = Color(0xFF5ED6E5);
  static const Color darkBackground1 = Color(0xFF0B1F2B);
  static const Color darkBackground2 = Color(0xFF132F40);
  static const Color darkBackground3 = Color(0xFF163A4D);
  static const Color white = Colors.white;
  static const Color white24 = Colors.white24;
  static const Color white54 = Colors.white54;
  static const Color red = Colors.red;
  static const Color transparent = Colors.transparent;
  static const Color black26 = Colors.black26;
  static const Color black54 = Colors.black54;
}

class AppGradients {
  static const RadialGradient background = RadialGradient(
    colors: [AppColors.darkBackground3, AppColors.darkBackground1],
    radius: 1.2,
    center: Alignment(0, -0.3),
  );
}
