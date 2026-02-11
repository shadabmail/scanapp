
import 'package:flutter/material.dart';
import '../utils/responsive.dart';
import '../widgets/app_header.dart';

const kBackgroundGradient = RadialGradient(
  colors: [
    Color(0xFF163A4D),
    Color(0xFF0B1F2B),
  ],
  radius: 1.2,
  center: Alignment(0, -0.3),
);

class AssetDetailScreen extends StatelessWidget {
  const AssetDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: kBackgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              const AppHeader(title: "Asset Coding", showBackButton: true),
              SizedBox(height: Responsive.hp(context, 3)),
              CircleAvatar(
                radius: Responsive.wp(context, 28),
                backgroundColor: Colors.white,
                child: Image.asset("assets/chair.png"),
              ),
              SizedBox(height: Responsive.hp(context, 3)),
              Text("Office Chair",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Responsive.sp(context, 20),
                      fontWeight: FontWeight.w500)),
              Padding(
                padding: EdgeInsets.all(Responsive.wp(context, 5)),
                child: Text(
                  "Indirect Asset Structure\nLCIDKSA - ABCC - AST - IND - ITEM - 00001",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: Responsive.sp(context, 13)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
