class AppConfig {
  // App Info
  static const String appName = 'LUCID';
  static const String appTitle = 'ScanApp';
  
  // Timing
  static const Duration doubleTapExitDuration = Duration(seconds: 2);
  static const Duration scanLoadingDuration = Duration(milliseconds: 1500);
  static const Duration snackBarDuration = Duration(seconds: 2);
  
  // Animation
  static const Duration pulseAnimationDuration = Duration(seconds: 2);
  static const double pulseScaleMin = 0.95;
  static const double pulseScaleMax = 1.05;
  
  // Scanner
  static const double scannerOverlaySize = 60.0; // percentage
  static const double scannerCornerLength = 0.2; // ratio
  static const double scanLineHeight = 3.0;
  
  // Form Validation
  static const int qrIdMinLength = 1;
  static const int assetNameMinLength = 1;
  
  // UI Sizes
  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusMedium = 12.0;
  static const double borderRadiusLarge = 20.0;
  static const double borderRadiusXLarge = 25.0;
  
  // Responsive Breakpoints
  static const double textScaleMin = 0.8;
  static const double textScaleMax = 1.2;
}
