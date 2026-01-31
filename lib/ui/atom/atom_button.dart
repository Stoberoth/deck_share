import 'package:deck_share/utils/app_color.dart';
import 'package:flutter/material.dart';

// Base button for all the application
// This is an atom because it's a base component of the application

class BaseButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const BaseButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 5.0,
        backgroundColor: AppColors.primary,
       padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: Text(label),
    );
  }
}
