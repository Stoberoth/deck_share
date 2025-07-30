import 'package:flutter/material.dart';

class BaseDismissible extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final Key dismissibleKey;
  final Widget child;

  const BaseDismissible({
    super.key,
    required this.dismissibleKey,
    required this.onDismissed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: dismissibleKey,
      background: Container(color: Colors.red),
      onDismissed: onDismissed,
      child: child,
    );
  }
}
