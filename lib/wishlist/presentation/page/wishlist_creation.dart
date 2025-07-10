// This page will be used to create a new wishlist

import 'package:deck_share/wishlist/domain/wishlist_model.dart';
import 'package:flutter/material.dart';

class WishlistCreationPage extends StatefulWidget {
  const WishlistCreationPage({super.key});

  @override
  State<WishlistCreationPage> createState() => _WishlistCreationPageState();
}

class _WishlistCreationPageState extends State<WishlistCreationPage> {
  List<String> cards = [];
  late TextEditingController nameController;
  late TextEditingController cardController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController();
    cardController = TextEditingController();
  }

  void addCard(String card) {
    if (card.isEmpty) {
      return;
    }
    setState(() {
      cards.add(card);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(
                context,
                Wishlist(name: nameController.text, cards: cards),
              );
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // need to add field to complete whishlist informations
              // add text controller to the text field
              TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Name of the wishlist",
                  hintText: "Name of the deck's wishlist",
                  icon: Icon(Icons.text_fields),
                ),
              ),
              // add cards to the wishlist and show the list of cards
              TextField(
                controller: cardController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Name of the card",
                  hintText: "Name of the card",
                  icon: Icon(Icons.text_fields),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  addCard(cardController.text);
                },
                child: Text("Add card"),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(cards[index]));
                },
                itemCount: cards.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
