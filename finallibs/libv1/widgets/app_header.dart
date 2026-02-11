import 'package:flutter/material.dart';
import '../utils/responsive.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final bool showBackButton;

  const AppHeader({
    super.key,
    required this.title,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.wp(context, 5),
        vertical: Responsive.hp(context, 2),
      ),
      child: Row(
        children: [
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
                fontWeight: FontWeight.w500,
              ),
              textAlign: showBackButton ? TextAlign.start : TextAlign.center,
            ),
          ),
          if (showBackButton) const SizedBox(width: 48),
        ],
      ),
    );
  }
}
