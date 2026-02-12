import 'package:deck_share/ui/atom/atom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Base App Bar for all the application
// Exemple of organism (complete section of UI) that is an assotiation of molecules and atom (imagine that we can add a search bar if we want)

class OrganismAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  const OrganismAppBar({Key? key, required this.title, this.actions})
    : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: TextStyle(color: Colors.white)),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      shadowColor: Colors.black,
      elevation: 5,
      actions: [
        AtomButton(
          label: "Log out",
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
        ),
      ],
    );
  }
}
