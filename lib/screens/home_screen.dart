
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config/app_config.dart';
import '../config/app_strings.dart';
import '../utils/app_theme.dart';
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
  DateTime? lastBackPress;

  void _refreshList() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      const DashboardScreen(),
      ScannerScreen(onCancel: () => setState(() => index = 0)),
      ViewListScreen(key: ValueKey(DateTime.now().millisecondsSinceEpoch)),
    ];
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        final now = DateTime.now();
        if (lastBackPress == null || now.difference(lastBackPress!) > AppConfig.doubleTapExitDuration) {
          lastBackPress = now;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppStrings.pressBackToExit), duration: AppConfig.snackBarDuration),
          );
        } else {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        body: pages[index],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: AppColors.darkBackground1,
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
            selectedItemColor: AppColors.primaryAccent,
            unselectedItemColor: Colors.white54,
            currentIndex: index,
            onTap: (i) => setState(() => index = i),
            selectedFontSize: 12,
            unselectedFontSize: 12,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: AppStrings.home),
              BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: AppStrings.scanNav),
              BottomNavigationBarItem(icon: Icon(Icons.list), label: AppStrings.assetsNav),
            ],
          ),
        ),
      ),
    );
  }
}
