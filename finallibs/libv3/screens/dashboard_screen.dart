
import 'package:flutter/material.dart';
import '../utils/responsive.dart';
import '../widgets/app_header.dart';
import 'login_screen.dart';
import 'scanner_screen.dart';
import 'add_asset_screen.dart';
import 'view_list_screen.dart';

const kBackgroundGradient = RadialGradient(
  colors: [
    Color(0xFF163A4D),
    Color(0xFF0B1F2B),
  ],
  radius: 1.2,
  center: Alignment(0, -0.3),
);

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: const Color(0xFF0B1F2B),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: Responsive.hp(context, 2)),
              Text(
                'L U C I D',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Responsive.sp(context, 24),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 6,
                ),
              ),
              SizedBox(height: Responsive.hp(context, 4)),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.white),
                title: Text('Logout', style: TextStyle(color: Colors.white, fontSize: Responsive.sp(context, 16))),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: kBackgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              const AppHeader(title: "Dashboard", showMenuButton: true),
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: Responsive.wp(context, 90),
                      maxHeight: Responsive.hp(context, 70),
                    ),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: Responsive.wp(context, 5),
                      runSpacing: Responsive.hp(context, 2),
                      children: [
                        SizedBox(
                          width: Responsive.wp(context, 40),
                          height: Responsive.wp(context, 40),
                          child: _Card(title: "Scan", icon: Icons.qr_code_scanner, onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const ScannerScreen()));
                          }),
                        ),
                        SizedBox(
                          width: Responsive.wp(context, 40),
                          height: Responsive.wp(context, 40),
                          child: _Card(title: "Add Asset", icon: Icons.add_box, onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const AddAssetScreen()));
                          }),
                        ),
                        SizedBox(
                          width: Responsive.wp(context, 40),
                          height: Responsive.wp(context, 40),
                          child: _Card(title: "Asset List", icon: Icons.checklist, onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const ViewListScreen()));
                          }),
                        ),
                        // const _Card(title: "Document", icon: Icons.description),
                      ],
                    ),
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

class _Card extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  const _Card({required this.title, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    final iconSize = Responsive.wp(context, 10).clamp(30.0, 50.0);
    final avatarRadius = iconSize * 1.2;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF132F40),
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(color: Colors.black54, blurRadius: 10)
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: avatarRadius,
              backgroundColor: Colors.white,
              child: Icon(icon, size: iconSize, color: Colors.black),
            ),
            SizedBox(height: Responsive.hp(context, 2)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.wp(context, 2)),
              child: Text(title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontSize: Responsive.sp(context, 14))),
            ),
          ],
        ),
      ),
    );
  }
}
