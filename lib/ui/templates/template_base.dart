import 'package:deck_share/utils/app_color.dart';
import 'package:flutter/material.dart';

// Template the determine the structure of the page without content ont the structure (generic layout)

class TemplateBase extends StatelessWidget {
  final Widget baseAppBar;
  final Widget body;
  final Color backgroundColor;
  final Widget? bottomNavBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const TemplateBase({
    super.key,
    required this.baseAppBar,
    required this.body,
    this.bottomNavBar,
    this.backgroundColor = AppColors.surface,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: baseAppBar,
      ),
      backgroundColor: backgroundColor,
      body: Padding(padding: const EdgeInsets.all(16.0), child: body),
      bottomNavigationBar: bottomNavBar,
      //backgroundColor: Colors.orange,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }
}
