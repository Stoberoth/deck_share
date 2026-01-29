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
    this.tileColor,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(15.0);
    
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        /*elevation: 10,
        shadowColor: Colors.black45,
        margin: EdgeInsets.all(1.0),*/
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          leading: leading,
          title: title,
          textColor: AppColors.textPrimary,
          subtitle: subtitle,
          trailing: trailing,
          selectedColor: selectedColor,
          tileColor: Theme.of(context).colorScheme.secondary,
          onTap: onTap,
          onLongPress: onLongPress,
        ),
      ),
    );
  }
}
