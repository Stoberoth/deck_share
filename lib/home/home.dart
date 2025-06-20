import 'package:deck_share/wishlist/domain/wishlist_model.dart';
import 'package:deck_share/wishlist/presentation/controller/whishlist_controller.dart';
import 'package:deck_share/wishlist/presentation/widget/wishlist_listview_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deck Share'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(wishlistViewerControllerProvider.notifier).addWishlist(Wishlist(id: "2", name: "test5", cards: []));
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              ref.read(wishlistViewerControllerProvider.notifier).deleteWishlist("2");
            },
            icon: Icon(Icons.minimize_rounded),
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
