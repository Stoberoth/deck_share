/// This file will be used to define the services for the wishlist
/// saving, deleting, updating, getting, etc.

import 'package:deck_share/wishlist/data/wishlist_local_repository.dart';
import 'package:deck_share/wishlist/domain/wishlist_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final wishlistServiceProvider = Provider<WishlistServices>((ref) {
  return WishlistServices(localRepository: ref.read(wishlistLocalRepositoryProvider));
});

class WishlistServices {
  WishlistServices({required this.localRepository});

  final WishlistLocalRepository localRepository;
  // save a wishlist
  Future<void> saveWishlist(Wishlist wishlist) async {
    await localRepository.saveWishlist(wishlist);
  }

  // load a specific wishlist
  Future<Wishlist> getWishlistById(String id) async {
    return await localRepository.getWishlistById(id);
  }

  // delete a wishlist
  Future<void> deleteWishlist(String id) async {
    await localRepository.deleteWishlist(id);
  }

  // update a wishlist
  Future<void> updateWishlist(Wishlist wishlist) async {
    await localRepository.updateWishlist(wishlist);
  }

  // get all wishlists
  Future<List<Wishlist>> getAllWishlists() async {
    return await localRepository.getAllWishlists();
  }
}

