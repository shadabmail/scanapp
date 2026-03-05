import 'dart:io';
import 'package:flutter/material.dart';
import '../utils/responsive.dart';
import '../utils/app_theme.dart';
import '../widgets/app_header.dart';
import '../models/asset_model.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AssetDetailScreen extends StatelessWidget {
  final Asset asset;
  
  const AssetDetailScreen({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.background),
        child: SafeArea(
          child: Column(
            children: [
              const AppHeader(title: "Asset Detail", showBackButton: true),
              SizedBox(height: Responsive.hp(context, 3)),
              Text(asset.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Responsive.sp(context, 20),
                      fontWeight: FontWeight.w500)),
              SizedBox(height: Responsive.hp(context, 3)),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(asset.imagePath),
                  width: Responsive.wp(context, 56),
                  height: Responsive.wp(context, 56),
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.inventory_2,
                    size: Responsive.wp(context, 40),
                    color: AppColors.primaryAccent,
                  ),
                ),
              ),
              SizedBox(height: Responsive.hp(context, 3)),
              ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      backgroundColor: Colors.transparent,
                      child: Container(
                        padding: EdgeInsets.all(Responsive.wp(context, 4)),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            QrImageView(
                              data: asset.qrId,
                              version: QrVersions.auto,
                              size: Responsive.wp(context, 60),
                            ),
                            SizedBox(height: Responsive.hp(context, 2)),
                            Text(
                              asset.qrId,
                              style: TextStyle(
                                fontSize: Responsive.sp(context, 14),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.qr_code_2, color: Colors.white, size: Responsive.sp(context, 14)),
                label: Text(
                  'View QR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Responsive.sp(context, 11),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryAccent,
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.wp(context, 3),
                    vertical: Responsive.hp(context, 0.8),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
              SizedBox(height: Responsive.hp(context, 2)),
              Padding(
                padding: EdgeInsets.all(Responsive.wp(context, 5)),
                child: Text(
                  "${asset.type} Asset\nQR ID: ${asset.qrId}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: Responsive.sp(context, 13)),
                ),
              ),
              if (asset.summary != null && asset.summary!.isNotEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Responsive.wp(context, 5)),
                  child: Container(
                    padding: EdgeInsets.all(Responsive.wp(context, 4)),
                    decoration: BoxDecoration(
                      color: AppColors.darkBackground2.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Summary",
                          style: TextStyle(
                            color: AppColors.primaryAccent,
                            fontSize: Responsive.sp(context, 14),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: Responsive.hp(context, 1)),
                        Text(
                          asset.summary!,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: Responsive.sp(context, 13),
                          ),
                        ),
                      ],
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
