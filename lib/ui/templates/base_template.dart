import 'package:flutter/material.dart';


// Template the determine the structure of the page without content ont the structure (generic layout)

class BaseTemplate extends StatelessWidget {
  final Widget baseAppBar;
  final Widget body;

  const BaseTemplate({super.key, required this.baseAppBar, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: baseAppBar,
      ),
      body: Padding(padding: const EdgeInsets.all(16.0), child: body),
    );
  }
}
