
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../utils/responsive.dart';
import '../widgets/app_header.dart';
import 'asset_detail_screen.dart';

const kBackgroundGradient = RadialGradient(
  colors: [
    Color(0xFF163A4D),
    Color(0xFF0B1F2B),
  ],
  radius: 1.2,
  center: Alignment(0, -0.3),
);

class ScannerScreen extends StatefulWidget {
  final VoidCallback? onCancel;
  const ScannerScreen({super.key, this.onCancel});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
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
    return WillPopScope(
      onWillPop: () async {
        if (widget.onCancel != null) {
          widget.onCancel!();
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(gradient: kBackgroundGradient),
          child: SafeArea(
            child: Column(
              children: [
                AppHeader(
                  title: "Scan",
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
                                  width: Responsive.wp(context, 60),
                                  height: Responsive.wp(context, 60),
                                  child: Stack(
                                    children: [
                                      CustomPaint(
                                        size: Size(Responsive.wp(context, 60), Responsive.wp(context, 60)),
                                        painter: ScannerOverlayPainter(),
                                      ),
                                      AnimatedBuilder(
                                        animation: _animationController,
                                        builder: (context, child) {
                                          return Positioned(
                                            top: _animationController.value * Responsive.wp(context, 60),
                                            left: 0,
                                            right: 0,
                                            child: Container(
                                              height: 3,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.transparent,
                                                    const Color(0xFF5ED6E5),
                                                    Colors.transparent,
                                                  ],
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: const Color(0xFF5ED6E5).withOpacity(0.8),
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
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5ED6E5).withOpacity(0.8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                            elevation: 5,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const AssetDetailScreen()),
                            );
                          },
                          icon: const Icon(Icons.qr_code_scanner, color: Colors.white, size: 20),
                          label: Text('Scan', style: TextStyle(color: Colors.white, fontSize: Responsive.sp(context, 14), fontWeight: FontWeight.w600)),
                        ),
                      ),
                      SizedBox(height: Responsive.hp(context, 1.5)),
                      SizedBox(
                        width: Responsive.wp(context, 50),
                        height: Responsive.hp(context, 5.5),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF132F40).withOpacity(0.8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                            elevation: 5,
                          ),
                          onPressed: () {
                            if (widget.onCancel != null) {
                              widget.onCancel!();
                            } else if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                          },
                          icon: const Icon(Icons.cancel, color: Colors.white, size: 20),
                          label: Text('Cancel', style: TextStyle(color: Colors.white, fontSize: Responsive.sp(context, 14), fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF5ED6E5)
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final glowPaint = Paint()
      ..color = const Color(0xFF5ED6E5).withOpacity(0.3)
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    final cornerLength = size.width * 0.2;

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
