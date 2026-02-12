
import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../utils/responsive.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.2,
            colors: [Color(0xFF1B3A57), Color(0xFF0F1923)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Responsive.wp(context, 10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: Responsive.hp(context, 8)),
                    Text(
                      'L U C I D',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Responsive.sp(context, 28),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 8,
                      ),
                    ),
                    SizedBox(height: Responsive.hp(context, 6)),
                    Container(
                      padding: EdgeInsets.all(Responsive.wp(context, 5)),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.cyan.withOpacity(0.5), width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.cyan.withOpacity(0.2),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Icon(Icons.lock_open_rounded, size: Responsive.wp(context, 20), color: Colors.lightBlueAccent),
                    ),
                    SizedBox(height: Responsive.hp(context, 8)),
                    _buildTextField(context, hint: 'E-mail'),
                    SizedBox(height: Responsive.hp(context, 2)),
                    _buildTextField(context, hint: 'Password', isPassword: true),
                    SizedBox(height: Responsive.hp(context, 2)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: Colors.white54),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text("Remember", style: TextStyle(color: Colors.white54, fontSize: Responsive.sp(context, 12))),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text("Forgot Password?", style: TextStyle(color: Colors.white54, fontSize: Responsive.sp(context, 12))),
                        ),
                      ],
                    ),
                    SizedBox(height: Responsive.hp(context, 4)),
                    Container(
                      width: double.infinity,
                      height: Responsive.hp(context, 6.5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF63D8E4), Color(0xFF4AC3D1)],
                        ),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const HomeScreen()),
                          );
                        },
                        child: Text("Log In", style: TextStyle(color: Colors.white, fontSize: Responsive.sp(context, 16), fontWeight: FontWeight.w600)),
                      ),
                    ),
                    SizedBox(height: Responsive.hp(context, 2)),
                    Text("Create", style: TextStyle(color: Colors.white, fontSize: Responsive.sp(context, 14))),
                    SizedBox(height: Responsive.hp(context, 2)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, {required String hint, bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      style: TextStyle(color: Colors.white, fontSize: Responsive.sp(context, 14)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white38, fontSize: Responsive.sp(context, 14)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        contentPadding: EdgeInsets.symmetric(horizontal: Responsive.wp(context, 5), vertical: Responsive.hp(context, 2)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.white38),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.cyan),
        ),
      ),
    );
  }
}
