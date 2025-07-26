import 'package:deck_share/wishlist/data/wishlist_local_repository.dart';
import 'package:deck_share/wishlist/domain/wishlist_model.dart';
import 'package:deck_share/wishlist/presentation/controller/whishlist_controller.dart';
import 'package:deck_share/wishlist/presentation/widget/wishlist_cards_listview_widget.dart';
import 'package:deck_share/wishlist/presentation/widget/wishlist_listview_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishlistEditPage extends ConsumerStatefulWidget {
  const WishlistEditPage({super.key});

  @override
  ConsumerState<WishlistEditPage> createState() => _WishlistEditPageState();
}

// able to edit the selected wishlist so we need to appear the name of the wishlist and change the cards in it (remove or add)
class _WishlistEditPageState extends ConsumerState<WishlistEditPage> {
  //TODO: add function to add cards in the list

  late Wishlist w;

  Future<Future> showAddCardDialog() async {
    TextEditingController controller = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Card to current Wishlist"),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Name of the card",
              icon: Icon(Icons.text_fields),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: Text("Validate"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String? _selectedIndex = ref
        .watch(wishlistViewerControllerProvider.notifier)
        .selected;
    return Scaffold(
      appBar: AppBar(title: Text("Edit Wishlist")),
      body: FutureBuilder(
        future: ref
            .watch(wishlistViewerControllerProvider.notifier)
            .getWishlistById(_selectedIndex!),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          w = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              children: [Text("Wishlist ${w.name}"), CardListViewWidget()],
            ),
          );
        },
      ),
    );
  }
}
