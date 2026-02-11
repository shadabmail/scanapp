import 'package:flutter/material.dart';
import '../utils/responsive.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final bool showBackButton;
  final bool showMenuButton;

  const AppHeader({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.showMenuButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.wp(context, 5),
        vertical: Responsive.hp(context, 2.5),
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF0B1F2B),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (showMenuButton)
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          if (showBackButton)
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: Responsive.sp(context, 24),
                fontWeight: FontWeight.w600,
              ),
              textAlign: (showBackButton || showMenuButton) ? TextAlign.start : TextAlign.center,
            ),
          ),
          if (showBackButton || showMenuButton) const SizedBox(width: 48),
        ],
      ),
    );
  }
}
