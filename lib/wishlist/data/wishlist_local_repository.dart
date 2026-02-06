/// This file will be used to define the local repository for the wishlist
/// It will be used to save, delete, update, get the wishlist
/// It will be used to save the wishlist to a file

import 'package:deck_share/wishlist/data/wishlist_repository.dart';
import 'package:deck_share/wishlist/domain/wishlist_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

final wishlistLocalRepositoryProvider = Provider<WishlistLocalRepository>((
  ref,
) {
  return WishlistLocalRepository();
});

class WishlistLocalRepository implements WishlistRepository {
  @override
  Future<void> saveWishlist(Wishlist wishlist) async {
    if (wishlist.id!.isEmpty) {
      wishlist.id = UniqueKey().toString();
    }
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/wishlist.json');
    //file.delete();
    if (!file.existsSync()) {
      file.create();
    }
    final json = await file.readAsString();
    final wishlists = jsonDecode(json);
    if (wishlists["wishlist"]
        .where((element) => element["id"] == wishlist.id)
        .isNotEmpty) {
      for (int i = 0; i < wishlists["wishlist"].length; ++i) {
        if (wishlists["wishlist"][i]["id"] == wishlist.id) {
          wishlists["wishlist"][i] = wishlist.toJson();
        }
      }
    } 
    else 
    {
      wishlists["wishlist"].add(wishlist.toJson());
    }
    file.writeAsString(jsonEncode(wishlists), mode: FileMode.writeOnly);
  }

  @override
  Future<void> deleteWishlist(String id) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/wishlist.json');
    //file.delete();
    if (!file.existsSync()) {
      file.create();
    }
    final json = await file.readAsString();
    final wishlists = jsonDecode(json);
    wishlists["wishlist"].removeWhere((element) => element["id"] == id);
    file.writeAsString(jsonEncode(wishlists), mode: FileMode.writeOnly);
  }

  @override
  Future<List<Wishlist>> getAllWishlists() async {
    /*final dir = await getApplicationDocumentsDirectory();
    final json = await rootBundle.loadString('ressources/wishlist.json');*/

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/wishlist.json');
    //file.delete();
    if (!file.existsSync()) {
      file.create();
      file.writeAsString(jsonEncode({"wishlist": []}));
    }
    final json = await file.readAsString();
    final wishlists = jsonDecode(json)["wishlist"];
    if (wishlists == null) {
      return [];
    }
    return List<Wishlist>.from(
      wishlists.map((wishlist) => Wishlist.fromJson(wishlist)),
    );
  }

  @override
  Future<Wishlist> getWishlistById(String id) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/wishlist.json');
    //file.delete();
    if (!file.existsSync()) {
      file.create();
      file.writeAsString(jsonEncode({"wishlist": []}));
    }
    final json = await file.readAsString();
    final wishlists = jsonDecode(json)["wishlist"];
    return Wishlist.fromJson(
      wishlists.where((element) => element["id"] == id).first,
    );
  }

  @override
  Future<void> updateWishlist(Wishlist wishlist) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/wishlist.json');
    //file.delete();
    if (!file.existsSync()) {
      return;
    }
    //final wishlists = jsonDecode(json);
    //await deleteWishlist(wishlist.id!);
    await saveWishlist(wishlist);
  }
}
