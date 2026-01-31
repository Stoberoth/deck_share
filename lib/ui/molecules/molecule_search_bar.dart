import 'package:flutter/material.dart';
import '../atom/atom_button.dart';
import '../atom/atom_text_field.dart';


// Base Search bar for the application
// Molecules are a combination of atoms here our base button and a textField that can be an atom later

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;

  const SearchBar({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BaseTextField( 
            controller: controller,
            hintText: "Search for ...",
          ),
        ),
        const SizedBox(width: 8),
        BaseButton(label: 'Search', onPressed: onSearch),
      ],
    );
  }
}
