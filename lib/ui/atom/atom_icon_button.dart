import 'package:flutter/material.dart';

class BaseIconButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback onPressed;

  const BaseIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(icon: icon, onPressed: onPressed);
  }
}
