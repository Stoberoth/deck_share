import 'package:flutter/material.dart';

// Base App Bar for all the application
// Exemple of organism (complete section of UI) that is an assotiation of molecules and atom (imagine that we can add a search bar if we want)

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  const BaseAppBar({Key? key, required this.title, this.actions}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: actions,
      backgroundColor: Colors.redAccent,
      //actions: [BaseButton(label: "Log out", onPressed: () {})],
    );
  }
}
