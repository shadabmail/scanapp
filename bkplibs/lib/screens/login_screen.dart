
import 'package:flutter/material.dart';
import '../routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text("LOGIN"),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, Routes.dashboard),
        ),
      ),
    );
  }
}
