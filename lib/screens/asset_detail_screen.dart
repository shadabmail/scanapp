
import 'package:flutter/material.dart';
import '../utils/responsive.dart';
import '../utils/app_theme.dart';
import '../widgets/app_header.dart';

class AssetDetailScreen extends StatelessWidget {
  const AssetDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.background),
        child: SafeArea(
          child: Column(
            children: [
              const AppHeader(title: "Asset Detail", showBackButton: true),
              SizedBox(height: Responsive.hp(context, 3)),
              Text("Office Chair",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Responsive.sp(context, 20),
                      fontWeight: FontWeight.w500)),
              SizedBox(height: Responsive.hp(context, 3)),
              CircleAvatar(
                radius: Responsive.wp(context, 28),
                backgroundColor: Colors.white,
                child: Image.asset("assets/chair.png"),
              ),
              SizedBox(height: Responsive.hp(context, 3)),
              Padding(
                padding: EdgeInsets.all(Responsive.wp(context, 5)),
                child: Text(
                  "Indirect Asset Structure\nLCIDKSA - ABCC - AST - IND - ITEM - 00001",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: Responsive.sp(context, 13)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Responsive.wp(context, 5)),
                child: Container(
                  padding: EdgeInsets.all(Responsive.wp(context, 4)),
                  decoration: BoxDecoration(
                    color: AppColors.darkBackground2.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Summary",
                        style: TextStyle(
                          color: AppColors.primaryAccent,
                          fontSize: Responsive.sp(context, 14),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: Responsive.hp(context, 1)),
                      Text(
                        "High-quality ergonomic office chair with adjustable height and lumbar support. Suitable for long working hours.",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: Responsive.sp(context, 13),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
