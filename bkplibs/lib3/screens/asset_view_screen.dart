
import 'package:flutter/material.dart';

class AssetViewScreen extends StatelessWidget {
  const AssetViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Asset Coding")),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [Color(0xFF102A43), Color(0xFF0B1E2D)],
            radius: 1.0,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundColor: Colors.white,
              child: Image.asset('assets/chair.png', height: 150),
            ),
            const SizedBox(height: 20),
            const Text("Office Chair",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text(
              "LCIDKSA - ABCC - AST - IND - ITEM - 00001",
              style: TextStyle(color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }
}
