
import 'package:flutter/material.dart';
import 'home_screen.dart';


const kBackgroundGradient = RadialGradient(
  colors: [
    Color(0xFF163A4D),
    Color(0xFF0B1F2B),
  ],
  radius: 1.2,
  center: Alignment(0, -0.3),
);

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          // Replicating the dark radial gradient background
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.2,
            colors: [Color(0xFF1B3A57), Color(0xFF0F1923)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              // LOGO Text
              const Text(
                'L U C I D',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 8,
                ),
              ),
              const SizedBox(height: 60),
              // The central Lock Icon with glow effect
              Container(
                padding: const EdgeInsets.all(20),
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
                child: const Icon(Icons.lock_open_rounded, size: 80, color: Colors.lightBlueAccent),
              ),
              const SizedBox(height: 80),
              // E-mail Field
              _buildTextField(hint: 'E-mail'),
              const SizedBox(height: 20),
              // Password Field
              _buildTextField(hint: 'Password', isPassword: true),
              const SizedBox(height: 15),
              // Remember & Forgot Password Row
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
                      const Text("Remember", style: TextStyle(color: Colors.white54, fontSize: 12)),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text("Forgot Password?", style: TextStyle(color: Colors.white54, fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              // Log In Button
              Container(
                width: double.infinity,
                height: 50,
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
                        MaterialPageRoute(
                            builder: (_) => const HomeScreen()),
                      );
                  },
                  child: const Text("Log In", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(height: 20),
              // Create Account Text
              const Text("Create", style: TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }

  // Helper to build the styled text fields
  Widget _buildTextField({required String hint, bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white38),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
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

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(gradient: kBackgroundGradient),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 30),
//             child: Column(
//               children: [
//                 const SizedBox(height: 40),
//                 const Text("LUCID",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 34,
//                         letterSpacing: 8,
//                         fontWeight: FontWeight.w300)),
//                 const SizedBox(height: 40),
//                 const Icon(Icons.lock_outline,
//                     size: 110, color: Color(0xFF5ED6E5)),
//                 const SizedBox(height: 50),
//                 _inputField("E-mail"),
//                 const SizedBox(height: 20),
//                 _inputField("Password", obscure: true),
//                 const SizedBox(height: 20),
//                 Row(
//                   children: const [
//                     Icon(Icons.check_box_outline_blank,
//                         color: Colors.white54),
//                     SizedBox(width: 8),
//                     Text("Remember",
//                         style: TextStyle(color: Colors.white54)),
//                     Spacer(),
//                     Text("Forgot Password?",
//                         style: TextStyle(color: Colors.white54)),
//                   ],
//                 ),
//                 const SizedBox(height: 40),
//                 SizedBox(
//                   width: double.infinity,
//                   height: 55,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(40)),
//                       backgroundColor: const Color(0xFF5ED6E5),
//                     ),
//                     onPressed: () {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                             builder: (_) => const HomeScreen()),
//                       );
//                     },
//                     child: const Text("Log In",
//                         style:
//                             TextStyle(fontSize: 18, color: Colors.white)),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 const Text("Create",
//                     style: TextStyle(color: Colors.white70)),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _inputField(String hint, {bool obscure = false}) {
//     return TextField(
//       obscureText: obscure,
//       style: const TextStyle(color: Colors.white),
//       decoration: InputDecoration(
//         hintText: hint,
//         hintStyle: const TextStyle(color: Colors.white54),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Colors.white38),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Color(0xFF5ED6E5)),
//         ),
//       ),
//     );
//   }
// }
