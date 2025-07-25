import 'package:deck_share/wishlist/domain/wishlist_model.dart';
import 'package:deck_share/wishlist/presentation/controller/whishlist_controller.dart';
import 'package:deck_share/wishlist/presentation/page/wishlist_creation.dart';
import 'package:deck_share/wishlist/presentation/widget/wishlist_listview_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeWishlistPage extends ConsumerWidget {
  const HomeWishlistPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deck Share : Wishlist'),
        backgroundColor: Colors.lightGreen,
      ),
      body: WishListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Wishlist w = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WishlistCreationPage()),
          );
          ref.read(wishlistViewerControllerProvider.notifier).addWishlist(w);
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
