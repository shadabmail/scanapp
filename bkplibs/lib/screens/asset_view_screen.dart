
import 'package:flutter/material.dart';

class AssetViewScreen extends StatelessWidget {
  const AssetViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Asset Details")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/chair.png', height: 200),
          const SizedBox(height: 20),
          const Text("Office Chair",
              style: TextStyle(color: Colors.white, fontSize: 22)),
        ],
      ),
    );
  }
}
