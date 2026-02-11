
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

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: kBackgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              const AppHeader(title: "Dashboard"),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: Responsive.hp(context, 2),
                  crossAxisSpacing: Responsive.wp(context, 5),
                  padding: EdgeInsets.all(Responsive.wp(context, 5)),
                  children: const [
                    _Card(title: "Scan", icon: Icons.qr_code_scanner),
                    _Card(title: "Add Asset", icon: Icons.add_box),
                    _Card(title: "Asset List", icon: Icons.checklist),
                    _Card(title: "Document", icon: Icons.description),
                  ],
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
  const _Card({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            radius: Responsive.wp(context, 8),
            backgroundColor: Colors.white,
            child: Icon(icon, size: Responsive.wp(context, 8), color: Colors.black),
          ),
          SizedBox(height: Responsive.hp(context, 2)),
          Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontSize: Responsive.sp(context, 16))),
        ],
      ),
    );
  }
}
