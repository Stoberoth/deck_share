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
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        elevation: 10,
        shadowColor: Colors.black45,
        margin: EdgeInsets.all(1.0),
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
      ),
    );
  }
}
