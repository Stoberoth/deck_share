import 'package:flutter/material.dart';

class BaseTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final Icon? icon;
  final ValueChanged? onSubmitted;
  final bool? enabled;

  const BaseTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.icon,
    this.onSubmitted,
    this.enabled
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(hintText: hintText, icon: icon,),
      enabled: enabled,
      onSubmitted: onSubmitted,
    );
  }
}
