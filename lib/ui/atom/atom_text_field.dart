import 'package:deck_share/utils/app_color.dart';
import 'package:flutter/material.dart';

class AtomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final Icon? icon;
  final Color textColor;
  final bool obscureText;
  final TextInputType keyboardInput;
  final ValueChanged? onSubmitted;
  final bool? enabled;

  const AtomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.textColor = AppColors.textPrimary,
    this.icon,
    this.keyboardInput = TextInputType.text,
    this.obscureText = false,
    this.onSubmitted,
    this.enabled
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
      style: TextStyle(color: textColor),
      keyboardType: keyboardInput,
      decoration: InputDecoration(hintText: hintText, icon: icon, hintStyle: TextStyle(color :AppColors.textSecondary)),
      enabled: enabled,
      onSubmitted: onSubmitted,
    );
  }
}
