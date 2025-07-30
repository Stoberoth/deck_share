import 'package:flutter/material.dart';


// Template the determine the structure of the page without content ont the structure (generic layout)

class BaseTemplate extends StatelessWidget {
  final Widget baseAppBar;
  final Widget body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const BaseTemplate({super.key, required this.baseAppBar, required this.body, this.floatingActionButton, this.floatingActionButtonLocation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: baseAppBar,
      ),
      body: Padding(padding: const EdgeInsets.all(16.0), child: body,),
      backgroundColor: Colors.orange,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }
}
