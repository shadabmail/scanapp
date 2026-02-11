
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
              const AppHeader(title: "Assets"),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(Responsive.wp(context, 5)),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: const Color(0xFF132F40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      margin: EdgeInsets.only(bottom: Responsive.hp(context, 2)),
                      child: ListTile(
                        title: Text(items[index],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Responsive.sp(context, 14))),
                        trailing: const Icon(Icons.arrow_forward_ios,
                            color: Colors.white54),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const AssetDetailScreen()));
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
