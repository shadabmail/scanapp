import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/responsive.dart';
import '../utils/app_theme.dart';
import '../utils/button_styles.dart';
import 'login_screen.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

  Future<void> _completeOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_complete', true);
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

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
                  Icons.inventory_2,
                  size: Responsive.wp(context, 35),
                  color: AppColors.primaryAccent,
                ),
                SizedBox(height: Responsive.hp(context, 4)),
                Text(
                  'Manage Everything',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: Responsive.sp(context, 26),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Responsive.hp(context, 2)),
                Text(
                  'Add, track, and organize all your assets in one place with powerful management tools',
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
                        color: Colors.white30,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: Responsive.wp(context, 2)),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: AppColors.primaryAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Responsive.hp(context, 4)),
                SizedBox(
                  width: double.infinity,
                  height: Responsive.hp(context, 6.5),
                  child: ElevatedButton(
                    style: AppButtonStyles.primary(),
                    onPressed: () => _completeOnboarding(context),
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: Responsive.sp(context, 16),
                        fontWeight: FontWeight.w600,
                      ),
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
