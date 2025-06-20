/// This file will be used to define the controller for the wishlist
/// It will be used to handle the logic for the wishlist

import 'package:deck_share/wishlist/application/wishlist_services.dart';
import 'package:deck_share/wishlist/domain/wishlist_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final wishlistModifierControllerProvider = StateNotifierProvider<WishlistModifierController, AsyncValue<void>>((ref) {
  return WishlistModifierController(wishlistServices: ref.read(wishlistServiceProvider));
});

final wishlistViewerControllerProvider = StateNotifierProvider<WishlistViewerController, AsyncValue<List<Wishlist>>>((ref) {
  return WishlistViewerController(wishlistServices: ref.read(wishlistServiceProvider));
});

class WishlistModifierController extends StateNotifier<AsyncValue<void>> {
  final WishlistServices wishlistServices;

  WishlistModifierController({required this.wishlistServices}) : super(const AsyncValue.data(null));

  Future<void> saveWishlist(Wishlist wishlist) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await wishlistServices.saveWishlist(wishlist);
    });
  }

  Future<void> deleteWishlist(String id) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await wishlistServices.deleteWishlist(id);
    });
  }

  Future<void> updateWishlist(Wishlist wishlist) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await wishlistServices.updateWishlist(wishlist);
    });
  } 
}

class WishlistViewerController extends StateNotifier<AsyncValue<List<Wishlist>>> {
  final WishlistServices wishlistServices;

  WishlistViewerController({required this.wishlistServices}) : super(const AsyncValue.data([]));

  Future<void> getAllWishlists() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await wishlistServices.getAllWishlists();
    });
  }
}