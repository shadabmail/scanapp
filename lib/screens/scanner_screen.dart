import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../config/app_config.dart';
import '../config/app_strings.dart';
import '../utils/responsive.dart';
import '../utils/app_theme.dart';
import '../utils/button_styles.dart';
import '../widgets/app_header.dart';
import '../widgets/loading_screen.dart';
import '../database/database_helper.dart';
import 'asset_detail_screen.dart';

class ScannerScreen extends StatefulWidget {
  final VoidCallback? onCancel;
  const ScannerScreen({super.key, this.onCancel});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;
  bool isScanning = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppConfig.pulseAnimationDuration,
      vsync: this,
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: AppConfig.pulseScaleMin, end: AppConfig.pulseScaleMax).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: widget.onCancel == null,
      onPopInvoked: (didPop) {
        if (!didPop && widget.onCancel != null) {
          widget.onCancel!();
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(gradient: AppGradients.background),
              child: SafeArea(
                child: Column(
                  children: [
                    AppHeader(
                      title: AppStrings.scan,
                      showBackButton: true,
                      onBackPressed: widget.onCancel ?? () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(Responsive.wp(context, 8)),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: MobileScanner(
                                onDetect: (capture) {
                                  final code = capture.barcodes.first.rawValue;
                                  if (code != null) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(content: Text(code)));
                                  }
                                },
                              ),
                            ),
                            Center(
                              child: AnimatedBuilder(
                                animation: _pulseAnimation,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: _pulseAnimation.value,
                                    child: SizedBox(
                                      width: Responsive.wp(context, AppConfig.scannerOverlaySize),
                                      height: Responsive.wp(context, AppConfig.scannerOverlaySize),
                                      child: Stack(
                                        children: [
                                          CustomPaint(
                                            size: Size(Responsive.wp(context, AppConfig.scannerOverlaySize), Responsive.wp(context, AppConfig.scannerOverlaySize)),
                                            painter: ScannerOverlayPainter(),
                                          ),
                                          AnimatedBuilder(
                                            animation: _animationController,
                                            builder: (context, child) {
                                              return Positioned(
                                                top: _animationController.value * Responsive.wp(context, AppConfig.scannerOverlaySize),
                                                left: 0,
                                                right: 0,
                                                child: Container(
                                                  height: AppConfig.scanLineHeight,
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        AppColors.transparent,
                                                        AppColors.primaryAccent,
                                                        AppColors.transparent,
                                                      ],
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: AppColors.primaryAccent.withOpacity(0.8),
                                                        blurRadius: 15,
                                                        spreadRadius: 3,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(Responsive.wp(context, 5)),
                      child: Column(
                        children: [
                          SizedBox(
                            width: Responsive.wp(context, 50),
                            height: Responsive.hp(context, 5.5),
                            child: ElevatedButton.icon(
                              style: AppButtonStyles.primaryWithOpacity(),
                              onPressed: () async {
                                setState(() => isScanning = true);
                                await Future.delayed(AppConfig.scanLoadingDuration);
                                setState(() => isScanning = false);
                                if (mounted) {
                                  final assets = await DatabaseHelper.instance.getAllAssets();
                                  if (assets.isNotEmpty) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => AssetDetailScreen(asset: assets.first)),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('No assets found')),
                                    );
                                  }
                                }
                              },
                              icon: const Icon(Icons.qr_code_scanner, color: AppColors.white, size: 20),
                              label: Text(AppStrings.scanButton, style: TextStyle(color: AppColors.white, fontSize: Responsive.sp(context, 14), fontWeight: FontWeight.w600)),
                            ),
                          ),
                          SizedBox(height: Responsive.hp(context, 1.5)),
                          SizedBox(
                            width: Responsive.wp(context, 50),
                            height: Responsive.hp(context, 5.5),
                            child: ElevatedButton.icon(
                              style: AppButtonStyles.secondary(),
                              onPressed: () {
                                if (widget.onCancel != null) {
                                  widget.onCancel!();
                                } else if (Navigator.canPop(context)) {
                                  Navigator.pop(context);
                                }
                              },
                              icon: const Icon(Icons.cancel, color: AppColors.white, size: 20),
                              label: Text(AppStrings.cancelButton, style: TextStyle(color: AppColors.white, fontSize: Responsive.sp(context, 14), fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (isScanning) const LoadingOverlay(message: AppStrings.scanning),
          ],
        ),
      ),
    );
  }
}

class ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryAccent
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final glowPaint = Paint()
      ..color = AppColors.primaryAccent.withOpacity(0.3)
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    final cornerLength = size.width * AppConfig.scannerCornerLength;

    // Draw glow effect
    canvas.drawLine(Offset(0, 0), Offset(cornerLength, 0), glowPaint);
    canvas.drawLine(Offset(0, 0), Offset(0, cornerLength), glowPaint);
    canvas.drawLine(Offset(size.width - cornerLength, 0), Offset(size.width, 0), glowPaint);
    canvas.drawLine(Offset(size.width, 0), Offset(size.width, cornerLength), glowPaint);
    canvas.drawLine(Offset(0, size.height - cornerLength), Offset(0, size.height), glowPaint);
    canvas.drawLine(Offset(0, size.height), Offset(cornerLength, size.height), glowPaint);
    canvas.drawLine(Offset(size.width - cornerLength, size.height), Offset(size.width, size.height), glowPaint);
    canvas.drawLine(Offset(size.width, size.height - cornerLength), Offset(size.width, size.height), glowPaint);

    // Draw corners
    canvas.drawLine(Offset(0, 0), Offset(cornerLength, 0), paint);
    canvas.drawLine(Offset(0, 0), Offset(0, cornerLength), paint);
    canvas.drawLine(Offset(size.width - cornerLength, 0), Offset(size.width, 0), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(size.width, cornerLength), paint);
    canvas.drawLine(Offset(0, size.height - cornerLength), Offset(0, size.height), paint);
    canvas.drawLine(Offset(0, size.height), Offset(cornerLength, size.height), paint);
    canvas.drawLine(Offset(size.width - cornerLength, size.height), Offset(size.width, size.height), paint);
    canvas.drawLine(Offset(size.width, size.height - cornerLength), Offset(size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
