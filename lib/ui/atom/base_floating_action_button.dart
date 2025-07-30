import 'package:flutter/material.dart';

class BaseFloatingActionButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  const BaseFloatingActionButton({
    super.key,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed: onPressed, backgroundColor: Colors.green, child: child,);
  }
}
