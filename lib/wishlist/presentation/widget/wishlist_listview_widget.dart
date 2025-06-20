import 'package:deck_share/wishlist/domain/wishlist_model.dart';
import 'package:deck_share/wishlist/presentation/controller/whishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// It will be used in the home page.
/// It will be used to display the wishlists of the user.

class WishListWidget extends ConsumerWidget {
  const WishListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Wishlist>> state = ref.watch(
      wishlistViewerControllerProvider,
    );
    ref.read(wishlistViewerControllerProvider.notifier).getAllWishlists();
    return Container(
      height: 500,
      child: state.isLoading
          ? const CircularProgressIndicator()
          : ListView.builder(
              shrinkWrap: true,
              itemCount: state.value?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Wishlist ${state.value?[index].name}'),
                  subtitle: Text(
                    'Number of cards: ${state.value?[index].cards.length}',
                  ),
                  leading: Icon(Icons.star),
                  trailing: Icon(Icons.arrow_forward),
                );
              },
            ),
    );
  }
}
