/// This file will be used to define the controller for the wishlist
/// It will be used to handle the logic for the wishlist

import 'package:deck_share/wishlist/application/wishlist_services.dart';
import 'package:deck_share/wishlist/domain/wishlist_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final wishlistViewerControllerProvider = StateNotifierProvider<WishlistViewerController, AsyncValue<List<Wishlist>>>((ref) {
  return WishlistViewerController(wishlistServices: ref.read(wishlistServiceProvider));
});


class WishlistViewerController extends StateNotifier<AsyncValue<List<Wishlist>>> {
  final WishlistServices wishlistServices;

  WishlistViewerController({required this.wishlistServices}) : super(const AsyncValue.data([]))
  {
    updateWishList();
  }

  Future<void> addWishlist(Wishlist wishlist) async {
    state = const AsyncLoading();
    await wishlistServices.saveWishlist(wishlist);
    updateWishList();
  }

  Future<void> deleteWishlist(String id) async {
    state = const AsyncLoading();
    await wishlistServices.deleteWishlist(id);
    updateWishList();
  }

  Future<void> updateWishList() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await wishlistServices.getAllWishlists();
    });
  }
}