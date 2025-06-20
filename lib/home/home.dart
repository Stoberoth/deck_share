import 'package:deck_share/wishlist/presentation/widget/wishlist_listview_widget.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deck Share'),
        actions: [
          IconButton(
            onPressed: () {
              print("add a wishlist");
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [WishListWidget(), Placeholder()]),
        ),
      ),
    );
  }
}
