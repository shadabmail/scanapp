import 'package:flutter/material.dart';
import 'responsive.dart';
import 'app_theme.dart';

class AppInputDecoration {
  static InputDecoration textField(
    BuildContext context, {
    required String label,
    required IconData icon,
    bool isRequired = false,
  }) {
    return InputDecoration(
      labelText: isRequired ? '$label *' : label,
      labelStyle: TextStyle(
        color: AppColors.primaryAccent,
        fontSize: Responsive.sp(context, 14),
      ),
      prefixIcon: Icon(icon, color: AppColors.primaryAccent),
      filled: true,
      fillColor: AppColors.white.withOpacity(0.08),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.white24),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryAccent, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.red, width: 2),
      ),
    );
  }

  static TextStyle textStyle(BuildContext context) {
    return TextStyle(
      color: AppColors.white,
      fontSize: Responsive.sp(context, 14),
    );
  }
}
