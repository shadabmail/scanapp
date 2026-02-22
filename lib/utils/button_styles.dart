import 'package:flutter/material.dart';
import 'app_theme.dart';

class AppButtonStyles {
  static ButtonStyle primary({double borderRadius = 25}) {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      elevation: 8,
    );
  }

  static ButtonStyle secondary({double borderRadius = 25}) {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.darkBackground2.withOpacity(0.8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      elevation: 5,
    );
  }

  static ButtonStyle primaryWithOpacity({double borderRadius = 25, double opacity = 0.8}) {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryAccent.withOpacity(opacity),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      elevation: 5,
    );
  }
}
