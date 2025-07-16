import 'package:deck_share/wishlist/domain/wishlist_model.dart';
import 'package:deck_share/wishlist/presentation/controller/whishlist_controller.dart';
import 'package:deck_share/wishlist/presentation/widget/wishlist_listview_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:deck_share/wishlist/presentation/page/wishlist_creation.dart';

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
            onPressed: () async {
              Wishlist w = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WishlistCreationPage()),
              );
              ref
                  .read(wishlistViewerControllerProvider.notifier)
                  .addWishlist(w);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [WishListWidget()]),
        ),
      ),
    );
  }
}
