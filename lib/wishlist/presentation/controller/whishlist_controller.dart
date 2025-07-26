/// This file will be used to define the controller for the wishlist
/// It will be used to handle the logic for the wishlist

import 'package:deck_share/wishlist/application/wishlist_services.dart';
import 'package:deck_share/wishlist/domain/wishlist_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scryfall_api/scryfall_api.dart';

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
    getWishList();
  }

  Future<void> selectedItem(String? selectedId) async {
    Wishlist w = await wishlistServices.getWishlistById(selectedId!);
    this.selected = w.id;
  }

  Future<void> addWishlist(Wishlist wishlist) async {
    state = const AsyncLoading();
    await wishlistServices.saveWishlist(wishlist);
    getWishList();
  }

  Future<void> deleteWishlist(String id) async {
    state = const AsyncLoading();
    print("id $id");
    await wishlistServices.deleteWishlist(id);
    getWishList();
  }

  Future<void> addCardToWishlistById(String id, MtgCard card) async {
    state = const AsyncLoading();
    Wishlist currentWishlist = await getWishlistById(id);
    print(currentWishlist.cards.length);
    currentWishlist.cards.add(card);
    await wishlistServices.updateWishlist(currentWishlist);
    getWishList();
  }

  Future<void> removeCardToWishlistById(String id, MtgCard card) async {
    state = const AsyncLoading();
    Wishlist currentWishlist = await getWishlistById(id);
    currentWishlist.cards.remove(card);
    await wishlistServices.updateWishlist(currentWishlist);
    getWishList();
  }

  Future<void> getWishList() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await wishlistServices.getAllWishlists();
    });
  }

  Future<void> updateWishlist(Wishlist wishlist) async {
    state = const AsyncLoading();
    wishlistServices.updateWishlist(wishlist);
    getWishList();
  }

  Future<Wishlist> getWishlistById(String id) async {
    final wishlist = await wishlistServices.getWishlistById(id);
    return wishlist;
  }
}
