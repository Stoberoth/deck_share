import 'package:flutter/material.dart';

// Base button for all the application
// This is an atom because it's a base component of the application

class BaseButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  BaseButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: Text(label),
    );
  }
}
