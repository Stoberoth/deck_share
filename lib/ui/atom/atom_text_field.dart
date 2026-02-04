import 'package:deck_share/utils/app_color.dart';
import 'package:flutter/material.dart';

class BaseTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final Icon? icon;
  final Color textColor;
  final ValueChanged? onSubmitted;
  final bool? enabled;

  const BaseTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.textColor = AppColors.textPrimary,
    this.icon,

    this.onSubmitted,
    this.enabled
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(color: textColor),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(hintText: hintText, icon: icon, hintStyle: TextStyle(color :AppColors.textSecondary)),
      enabled: enabled,
      onSubmitted: onSubmitted,
    );
  }
}
