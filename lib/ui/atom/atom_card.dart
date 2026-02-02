import 'package:deck_share/utils/app_color.dart';
import 'package:flutter/material.dart';

class BaseCard extends StatelessWidget {
  final Widget? child;
  final Color? color;
  const BaseCard({super.key, this.child, this.color = AppColors.surface});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: AppColors.primaryLight),
      ),
      color: color,
      child: child,
    );
  }
}
