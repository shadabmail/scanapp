
import 'package:flutter/material.dart';
import '../routes.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text("EDIT → SCAN"),
          onPressed: () =>
              Navigator.pushNamed(context, Routes.scanner),
        ),
      ),
    );
  }
}
