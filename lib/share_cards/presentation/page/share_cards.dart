import 'package:flutter/material.dart';

/// Page to create a share cards
///

class ShareCardsPage extends StatefulWidget {
  const ShareCardsPage({super.key});

  @override
  State<ShareCardsPage> createState() => _ShareCardsPageState();
}

class _ShareCardsPageState extends State<ShareCardsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Share Cards")),
      body: SafeArea(child: SingleChildScrollView(child: Column())),
    );
  }
}
