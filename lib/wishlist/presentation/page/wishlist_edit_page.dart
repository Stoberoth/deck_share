import 'package:deck_share/wishlist/data/wishlist_local_repository.dart';
import 'package:deck_share/wishlist/domain/wishlist_model.dart';
import 'package:deck_share/wishlist/presentation/controller/whishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishlistEditPage extends ConsumerStatefulWidget {
  const WishlistEditPage({super.key});

  @override
  ConsumerState<WishlistEditPage> createState() => _WishlistEditPageState();
}

// able to edit the selected wishlist so we need to appear the name of the wishlist and change the cards in it (remove or add)
class _WishlistEditPageState extends ConsumerState<WishlistEditPage> {
  @override
  Widget build(BuildContext context) {
    
    String? _selectedIndex = ref
        .watch(wishlistViewerControllerProvider.notifier)
        .selected;
    return Scaffold(
      appBar: AppBar(title: Text("Edit Wishlist")),
      body: FutureBuilder(
        future: ref
            .watch(wishlistViewerControllerProvider.notifier)
            .getWishlistById(_selectedIndex!),
        builder: (context, snapshot) {
          return Column(children: [Text("Wishlist ${snapshot.data?.name}")],) ;
        },
      ),
    );
  }
}
