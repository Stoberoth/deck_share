import 'package:deck_share/ui/atom/atom_text_field.dart';
import 'package:deck_share/ui/organisms/organism_app_bar.dart';
import 'package:deck_share/ui/templates/template_base.dart';
import 'package:deck_share/wishlist/domain/wishlist_model.dart';
import 'package:deck_share/wishlist/presentation/widget/wishlist_cards_listview_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO add possibility to create a share card list with the pick cards of this page
class WishlistEditPage extends ConsumerStatefulWidget {
  const WishlistEditPage({super.key, required this.wishlist});
  final Wishlist wishlist;
  @override
  ConsumerState<WishlistEditPage> createState() => _WishlistEditPageState();
}

// able to edit the selected wishlist so we need to appear the name of the wishlist and change the cards in it (remove or add)
class _WishlistEditPageState extends ConsumerState<WishlistEditPage> {
 
  @override
  Widget build(BuildContext context) {
    return BaseTemplate(
      baseAppBar: BaseAppBar(title: "Edit Wishlist ${widget.wishlist.name}"),
      body: CardListViewWidget(wishlist: widget.wishlist),
    );
  }
}
