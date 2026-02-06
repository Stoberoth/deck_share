import 'package:flutter/material.dart';

class AtomIconButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback onPressed;

  const AtomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(icon: icon, onPressed: onPressed);
  }
}
