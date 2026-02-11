
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/scanner_screen.dart';
import 'screens/loading_screen.dart';
import 'screens/asset_view_screen.dart';

class Routes {
  static const login = '/';
  static const dashboard = '/dashboard';
  static const scanner = '/scanner';
  static const loading = '/loading';
  static const view = '/view';
}

final appRoutes = {
  Routes.login: (_) => const LoginScreen(),
  Routes.dashboard: (_) => const DashboardScreen(),
  Routes.scanner: (_) => const ScannerScreen(),
  Routes.loading: (_) => const LoadingScreen(),
  Routes.view: (_) => const AssetViewScreen(),
};
