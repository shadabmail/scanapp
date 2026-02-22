import 'package:flutter/material.dart';
import 'app_theme.dart';

class AppContainerDecoration {
  static BoxDecoration card({double borderRadius = 20, double opacity = 0.6}) {
    return BoxDecoration(
      color: AppColors.darkBackground2.withOpacity(opacity),
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: const [
        BoxShadow(
          color: AppColors.black26,
          blurRadius: 15,
          offset: Offset(0, 5),
        ),
      ],
    );
  }

  static BoxDecoration dashboardCard({double borderRadius = 25}) {
    return BoxDecoration(
      color: AppColors.darkBackground2,
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: const [
        BoxShadow(color: AppColors.black54, blurRadius: 10),
      ],
    );
  }

  static BoxDecoration imagePicker({
    required bool hasError,
    double borderRadius = 12,
  }) {
    return BoxDecoration(
      color: AppColors.white.withOpacity(0.08),
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: hasError
            ? AppColors.red
            : AppColors.primaryAccent.withOpacity(0.3),
        width: 2,
      ),
    );
  }
}
