import 'package:deck_share/utils/app_color.dart';
import 'package:flutter/material.dart';

class BaseCard extends StatelessWidget {
  final Widget? child;
  const BaseCard({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: AppColors.primaryLight),
      ),
      color: Theme.of(context).colorScheme.secondary,
      child: child,
    );
  }
}
