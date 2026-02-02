import 'package:deck_share/utils/app_color.dart';
import 'package:flutter/material.dart';

class BaseListTile extends StatelessWidget {
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final Color? selectedColor;
  final Color? tileColor;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const BaseListTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.selectedColor,
    this.tileColor = AppColors.surface,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
        child: ListTile(
          leading: leading,
          title: title,
          subtitle: subtitle,
          trailing: trailing,
          selectedColor: selectedColor,
          tileColor: tileColor,
          onTap: onTap,
          onLongPress: onLongPress,
        ),
    );
  }
}
