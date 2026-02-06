

import 'package:flutter/material.dart';

class TemplateHome extends StatelessWidget {
  const TemplateHome({super.key, required this.body/*, required this.bottomNavigationBar*/});
  final Widget body;
  //final Widget bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
     // bottomNavigationBar: bottomNavigationBar,
    );
  }
}