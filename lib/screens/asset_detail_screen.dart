
import 'package:flutter/material.dart';


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
              const SizedBox(height: 20),
              const Text("Asset Coding",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w500)),
              const SizedBox(height: 30),
              CircleAvatar(
                radius: 110,
                backgroundColor: Colors.white,
                child: Image.asset("assets/chair.png"),
              ),
              const SizedBox(height: 30),
              const Text("Office Chair",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500)),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Indirect Asset Structure\nLCIDKSA - ABCC - AST - IND - ITEM - 00001",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
