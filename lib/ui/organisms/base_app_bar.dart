import 'package:flutter/material.dart';
import '../atom/base_button.dart';

// Base App Bar for all the application
// Exemple of organism (complete section of UI) that is an assotiation of molecules and atom (imagine that we can add a search bar if we want)

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const BaseAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: Colors.redAccent,
      //actions: [BaseButton(label: "Log out", onPressed: () {})],
    );
  }
}
