import 'package:flutter/material.dart';
import '../utils/responsive.dart';
import '../utils/app_theme.dart';

class LoadingScreen extends StatelessWidget {
  final String message;

  const LoadingScreen({
    super.key,
    this.message = 'Loading...',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppGradients.background),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: Responsive.wp(context, 20),
              height: Responsive.wp(context, 20),
              child: CircularProgressIndicator(
                strokeWidth: 4,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryAccent),
              ),
            ),
            SizedBox(height: Responsive.hp(context, 3)),
            Text(
              message,
              style: TextStyle(
                color: AppColors.white,
                fontSize: Responsive.sp(context, 16),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingOverlay extends StatelessWidget {
  final String message;

  const LoadingOverlay({
    super.key,
    this.message = 'Processing...',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(Responsive.wp(context, 8)),
          decoration: BoxDecoration(
            color: AppColors.darkBackground2,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: AppColors.black26,
                blurRadius: 15,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: Responsive.wp(context, 15),
                height: Responsive.wp(context, 15),
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryAccent),
                ),
              ),
              SizedBox(height: Responsive.hp(context, 2)),
              Text(
                message,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: Responsive.sp(context, 14),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
