import 'package:flutter/material.dart';
import '../utils/responsive.dart';
import '../utils/app_theme.dart';

class AppRadioGroup extends StatelessWidget {
  final String label;
  final String value;
  final List<String> options;
  final Function(String) onChanged;

  const AppRadioGroup({
    super.key,
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            color: AppColors.primaryAccent,
            fontSize: Responsive.sp(context, 14),
            fontWeight: FontWeight.w500,
          ),
        ),
        ...options.map((option) => [
          Radio<String>(
            value: option,
            groupValue: value,
            activeColor: AppColors.primaryAccent,
            onChanged: (val) => onChanged(val!),
          ),
          Text(
            option,
            style: TextStyle(
              color: AppColors.white,
              fontSize: Responsive.sp(context, 14),
            ),
          ),
          if (option != options.last) SizedBox(width: Responsive.wp(context, 5)),
        ]).expand((e) => e),
      ],
    );
  }
}
