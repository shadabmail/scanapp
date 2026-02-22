import 'package:flutter/material.dart';
import '../utils/responsive.dart';
import '../utils/input_decoration.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool isRequired;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final int maxLines;

  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.isRequired = false,
    this.validator,
    this.onChanged,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      maxLines: maxLines,
      style: AppInputDecoration.textStyle(context),
      decoration: AppInputDecoration.textField(
        context,
        label: label,
        icon: icon,
        isRequired: isRequired,
      ),
      validator: validator,
    );
  }
}
