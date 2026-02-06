import 'package:flutter/material.dart';

class AtomFloatingActionButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  const AtomFloatingActionButton({
    super.key,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(shape: const CircleBorder(),onPressed:  onPressed, backgroundColor: Theme.of(context).colorScheme.primary, child: child,);
  }
}
