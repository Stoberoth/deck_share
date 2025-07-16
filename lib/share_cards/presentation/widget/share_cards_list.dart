import 'dart:developer';

import 'package:deck_share/share_cards/domain/share_cards_model.dart';
import 'package:deck_share/share_cards/presentation/controller/share_cards_controller.dart';
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
    final AsyncValue<List<ShareCards>> state = ref.watch(
      shareCardsControllerProvider,
    );
    //ref.read(wishlistViewerControllerProvider.notifier).getAllWishlists();
    List<ShareCards> shareCardsList = state.value ?? [];
    return ListView.builder(
      itemCount: shareCardsList.length,
      itemBuilder: (context, index) {},
    );
  }
}
