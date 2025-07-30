import 'package:deck_share/ui/atom/base_dismissible.dart';
import 'package:deck_share/ui/atom/base_list_tile.dart';
import 'package:deck_share/wishlist/domain/wishlist_model.dart';
import 'package:deck_share/wishlist/presentation/controller/whishlist_controller.dart';
import 'package:deck_share/wishlist/presentation/page/wishlist_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// It will be used in the home page.
/// It will be used to display the wishlists of the user.
///

class WishListWidget extends ConsumerStatefulWidget {
  const WishListWidget({super.key});

  @override
  ConsumerState<WishListWidget> createState() => _WishListWidgetState();
}

class _WishListWidgetState extends ConsumerState<WishListWidget> {
  String? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<Wishlist>> state = ref.watch(
      wishlistViewerControllerProvider,
    );
    //ref.read(wishlistViewerControllerProvider.notifier).getAllWishlists();
    List<Wishlist> wishlists = state.value ?? [];
    return Container(
      height: 500,
      child: state.isLoading
          ? const CircularProgressIndicator()
          : ListView.builder(
              shrinkWrap: true,
              itemCount: wishlists.length,
              itemBuilder: (context, index) {
                // need to rewrite this to change the text to have another presentation
                return BaseDismissible(
                  dismissibleKey: ValueKey(index),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.endToStart ||
                        direction == DismissDirection.startToEnd) {
                      ref
                          .read(wishlistViewerControllerProvider.notifier)
                          .deleteWishlist(wishlists[index].id!);
                    }
                  },
                  child: BaseListTile(
                    leading: Icon(Icons.card_giftcard),
                    title: Text('Wishlist ${wishlists[index].name}'),
                    subtitle: Text(
                      'Number of cards: ${wishlists[index].cards.length}',
                    ),
                    onTap: () async {
                      await ref
                          .read(wishlistViewerControllerProvider.notifier)
                          .selectedItem(wishlists[index].id);
                      setState(() {
                        _selectedIndex = wishlists[index].id;
                      });
                      await ref
                          .read(wishlistViewerControllerProvider.notifier)
                          .selectedItem(wishlists[index].id);
                      setState(() {
                        _selectedIndex = wishlists[index].id;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              WishlistEditPage(wishlist: wishlists[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
