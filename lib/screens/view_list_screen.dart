
import 'package:flutter/material.dart';
import '../config/app_strings.dart';
import 'asset_detail_screen.dart';
import '../utils/responsive.dart';
import '../utils/app_theme.dart';
import '../widgets/app_header.dart';

class ViewListScreen extends StatelessWidget {
  const ViewListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(5, (i) => "Office Chair #${i + 1}");

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppGradients.background),
        child: SafeArea(
          child: Column(
            children: [
              const AppHeader(title: AppStrings.assets, showBackButton: true),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(Responsive.wp(context, 5)),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
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
                        leading: CircleAvatar(
                          backgroundColor: AppColors.primaryAccent,
                          child: Icon(Icons.inventory_2, color: AppColors.white, size: Responsive.wp(context, 6)),
                        ),
                        title: Text(
                          items[index],
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: Responsive.sp(context, 15),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          AppStrings.tapToViewDetails,
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
                            MaterialPageRoute(builder: (_) => const AssetDetailScreen()),
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
