/// This file will be used to define the controller for the wishlist
/// It will be used to handle the logic for the wishlist

import 'package:deck_share/wishlist/application/wishlist_services.dart';
import 'package:deck_share/wishlist/domain/wishlist_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedWishlist = StateProvider<String>((ref) {
  return "";
});

final wishlistViewerControllerProvider =
    StateNotifierProvider<WishlistViewerController, AsyncValue<List<Wishlist>>>(
      (ref) {
        return WishlistViewerController(
          wishlistServices: ref.read(wishlistServiceProvider),
          selected: ref.read(selectedWishlist),
        );
      },
    );

class WishlistViewerController
    extends StateNotifier<AsyncValue<List<Wishlist>>> {
  final WishlistServices wishlistServices;
  String? selected;

  WishlistViewerController({
    required this.wishlistServices,
    required this.selected,
  }) : super(const AsyncValue.data([])) {
    updateWishList();
  }

  Future<void> selectedItem(String? selectedId) async {
    Wishlist w = await wishlistServices.getWishlistById(selectedId!);
    this.selected = w.id;
  }

  Future<void> addWishlist(Wishlist wishlist) async {
    state = const AsyncLoading();
    await wishlistServices.saveWishlist(wishlist);
    updateWishList();
  }

  Future<void> deleteWishlist(String id) async {
    state = const AsyncLoading();
    print("id $id");
    await wishlistServices.deleteWishlist(id);
    updateWishList();
  }

  Future<void> addCardToWishlistById(String id, String cardName) async {
    state = const AsyncLoading();
    Wishlist currentWishlist = await getWishlistById(id);
    print(currentWishlist.cards.length);
    currentWishlist.cards.add(cardName);
    await wishlistServices.updateWishlist(currentWishlist);
    updateWishList();
  }

  Future<void> removeCardToWishlistById(String id, String cardName) async {
    state = const AsyncLoading();
    Wishlist currentWishlist = await getWishlistById(id);
    currentWishlist.cards.remove(cardName);
    await wishlistServices.updateWishlist(currentWishlist);
    updateWishList();
  }

  Future<void> updateWishList() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await wishlistServices.getAllWishlists();
    });
  }

  Future<Wishlist> getWishlistById(String id) async {
    final wishlist = await wishlistServices.getWishlistById(id);
    return wishlist;
  }
}
