/// This file will be used to define the local repository for the wishlist
/// It will be used to save, delete, update, get the wishlist
/// It will be used to save the wishlist to a file

import 'package:deck_share/wishlist/data/wishlist_repository.dart';
import 'package:deck_share/wishlist/domain/wishlist_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'dart:io';

final wishlistLocalRepositoryProvider = Provider<WishlistLocalRepository>((ref) {
  return WishlistLocalRepository();
});



class WishlistLocalRepository implements WishlistRepository {
  @override
  Future<void> saveWishlist(Wishlist wishlist) async {
    // TODO: implement saveWishlist
    throw UnimplementedError();
  }
  
  @override
  Future<void> deleteWishlist(String id) {
    // TODO: implement deleteWishlist
    throw UnimplementedError();
  }
  
  @override
  Future<List<Wishlist>> getAllWishlists() async{
    final json = await rootBundle.loadString('ressources/wishlist.json');
    final wishlists = jsonDecode(json)["wishlists"];
    return List<Wishlist>.from(wishlists.map((wishlist) => Wishlist.fromJson(wishlist)));
  }
  
  @override
  Future<Wishlist> getWishlistById(String id) {
    // TODO: implement getWishlistById
    throw UnimplementedError();
  }
  
  @override
  Future<void> updateWishlist(Wishlist wishlist) {
    // TODO: implement updateWishlist
    throw UnimplementedError();
  }
}