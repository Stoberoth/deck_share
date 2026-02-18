
import 'package:deck_share/ui/atom/atom_button.dart';
import 'package:flutter/material.dart';

class AtomLogoutButton extends StatelessWidget{
  final String label;
  final VoidCallback onPressed;
  AtomLogoutButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AtomButton(label: "Log Out", onPressed: onPressed);
  }}