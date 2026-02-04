import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:deck_share/utils/app_color.dart';
import 'package:flutter/material.dart';

// Base button for all the application
// This is an atom because it's a base component of the application

class BaseButton extends StatelessWidget {
  final String label;
  final Color buttonColor;
  final VoidCallback onPressed;

  const BaseButton({super.key, required this.label, required this.onPressed, this.buttonColor = AppColors.primary});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 5.0,
        backgroundColor: buttonColor,
       padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: BaseText(data: label,fontSize: 18,)
    );
  }
}
