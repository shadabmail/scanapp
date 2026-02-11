
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
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

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: kBackgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              const AppHeader(title: "Scan"),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(Responsive.wp(context, 8)),
                  child: ClipRRect(
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
