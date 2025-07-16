import 'dart:developer';

import 'package:deck_share/wishlist/presentation/controller/whishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShareCardsListWidget extends ConsumerStatefulWidget {
  const ShareCardsListWidget({super.key});

  @override
  ConsumerState<ShareCardsListWidget> createState() =>
      _ShareCardsListWidgetState();
}

class _ShareCardsListWidgetState extends ConsumerState<ShareCardsListWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // TODO: change to use the repository of shared cards
      future: ref
          .read(wishlistViewerControllerProvider.notifier)
          .getWishlistById("0"),
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: snapshot.data!.cards.length,
          itemBuilder: (context, index) {},
        );
      },
    );
  }
}
