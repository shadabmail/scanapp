import 'package:flutter/material.dart';
import '../utils/responsive.dart';
import '../utils/app_theme.dart';
import 'onboarding_screen2.dart';

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.background),
        child: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
              ),
              child: Padding(
                padding: EdgeInsets.all(Responsive.wp(context, 8)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Icon(
                  Icons.qr_code_scanner,
                  size: Responsive.wp(context, 35),
                  color: AppColors.primaryAccent,
                ),
                SizedBox(height: Responsive.hp(context, 4)),
                Text(
                  'Scan Assets Instantly',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: Responsive.sp(context, 26),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Responsive.hp(context, 2)),
                Text(
                  'Use QR code scanning to quickly identify and track your assets with ease',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: Responsive.sp(context, 15),
                  ),
                ),
                SizedBox(height: Responsive.hp(context, 8)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: AppColors.primaryAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: Responsive.wp(context, 2)),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.white30,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Responsive.hp(context, 4)),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const OnboardingScreen2()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.wp(context, 8),
                      vertical: Responsive.hp(context, 1.5),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryAccent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Next',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: Responsive.sp(context, 16),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: Responsive.wp(context, 2)),
                        Icon(Icons.arrow_forward, color: AppColors.white, size: 20),
                      ],
                    ),
                  ),
                ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
