import 'package:deck_share/ui/atom/base_floating_action_button.dart';
import 'package:deck_share/ui/organisms/base_app_bar.dart';
import 'package:deck_share/ui/templates/base_template.dart';
import 'package:deck_share/wishlist/domain/wishlist_model.dart';
import 'package:deck_share/wishlist/presentation/controller/whishlist_controller.dart';
import 'package:deck_share/wishlist/presentation/page/wishlist_creation.dart';
import 'package:deck_share/wishlist/presentation/widget/wishlist_listview_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeWishlistPage extends ConsumerWidget {
  const HomeWishlistPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseTemplate(
      baseAppBar: BaseAppBar(title: 'DeckShare : Wishlist'),
      body: WishListWidget(),
      floatingActionButton: BaseFloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          Wishlist? w = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WishlistCreationPage()),
          );
          if (w != null) {
            ref.read(wishlistViewerControllerProvider.notifier).addWishlist(w);
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
