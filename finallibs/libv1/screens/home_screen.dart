
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

  final pages = const [
    DashboardScreen(),
    ScannerScreen(),
    ViewListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF0B1F2B),
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
    );
  }
}
