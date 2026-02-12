
import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'scanner_screen.dart';
import 'view_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const DashboardScreen(),
      ScannerScreen(onCancel: () => setState(() => index = 0)),
      const ViewListScreen(),
    ];
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0B1F2B),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: const Color(0xFF5ED6E5),
          unselectedItemColor: Colors.white54,
          currentIndex: index,
          onTap: (i) => setState(() => index = i),
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: "Scan"),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "Assets"),
          ],
        ),
      ),
    );
  }
}
