
import 'package:flutter/material.dart';
import 'asset_detail_screen.dart';
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

class ViewListScreen extends StatelessWidget {
  const ViewListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(5, (i) => "Office Chair #${i + 1}");

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: kBackgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              const AppHeader(title: "Assets", showBackButton: true),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(Responsive.wp(context, 5)),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: Responsive.hp(context, 2)),
                      decoration: BoxDecoration(
                        color: const Color(0xFF132F40),
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
                          backgroundColor: const Color(0xFF5ED6E5),
                          child: Icon(Icons.inventory_2, color: Colors.white, size: Responsive.wp(context, 6)),
                        ),
                        title: Text(
                          items[index],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Responsive.sp(context, 15),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          'Tap to view details',
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: Responsive.sp(context, 12),
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: const Color(0xFF5ED6E5),
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
