import 'package:deck_share/wishlist/domain/wishlist_model.dart';

abstract class WishlistRepository {
  Future<void> saveWishlist(Wishlist wishlist);
  Future<Wishlist> getWishlistById(String id);
  Future<void> deleteWishlist(String id);
  Future<void> updateWishlist(Wishlist wishlist);
  Future<List<Wishlist>> getAllWishlists();
}


