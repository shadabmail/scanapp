import 'dart:io';
import 'package:flutter/material.dart';
import '../config/app_strings.dart';
import 'asset_detail_screen.dart';
import '../utils/responsive.dart';
import '../utils/app_theme.dart';
import '../widgets/app_header.dart';
import '../database/database_helper.dart';
import '../models/asset_model.dart';

class ViewListScreen extends StatefulWidget {
  const ViewListScreen({super.key});

  @override
  State<ViewListScreen> createState() => _ViewListScreenState();
}

class _ViewListScreenState extends State<ViewListScreen> {
  List<Asset> assets = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAssets();
  }

  Future<void> _loadAssets() async {
    final data = await DatabaseHelper.instance.getAllAssets();
    setState(() {
      assets = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppGradients.background),
        child: SafeArea(
          child: Column(
            children: [
              const AppHeader(title: AppStrings.assets, showBackButton: true),
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator(color: Color(0xFF5ED6E5)))
                    : assets.isEmpty
                        ? Center(
                            child: Text(
                              'No assets found',
                              style: TextStyle(color: Colors.white, fontSize: Responsive.sp(context, 16)),
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.all(Responsive.wp(context, 5)),
                            itemCount: assets.length,
                            itemBuilder: (context, index) {
                              final asset = assets[index];
                              return Container(
                                margin: EdgeInsets.only(bottom: Responsive.hp(context, 2)),
                                decoration: BoxDecoration(
                                  color: AppColors.darkBackground2,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: const [
                                    BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 2))
                                  ],
                                ),
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: Responsive.wp(context, 4),
                                    vertical: Responsive.hp(context, 1),
                                  ),
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      File(asset.imagePath),
                                      width: Responsive.wp(context, 12),
                                      height: Responsive.wp(context, 12),
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => CircleAvatar(
                                        backgroundColor: AppColors.primaryAccent,
                                        child: Icon(Icons.inventory_2, color: AppColors.white),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    asset.name,
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: Responsive.sp(context, 15),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'QR: ${asset.qrId} • ${asset.type}',
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: Responsive.sp(context, 12),
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    color: AppColors.primaryAccent,
                                    size: Responsive.wp(context, 4),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => AssetDetailScreen(asset: asset)),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
