import 'package:deck_share/wishlist/data/wishlist_local_repository.dart';
import 'package:deck_share/wishlist/domain/wishlist_model.dart';
import 'package:deck_share/wishlist/presentation/controller/whishlist_controller.dart';
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

  void addCard(String cardName) async {
    w.cards.add(cardName);
    await ref
        .read(wishlistLocalRepositoryProvider)
        .updateWishlist(w);
    await ref.read(wishlistViewerControllerProvider.notifier).updateWishList();
    setState(() {});
  }

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
                addCard(controller.text);
                Navigator.pop(context, controller.text);
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
      appBar: AppBar(
        title: Text("Edit Wishlist"),
        actions: [
          TextButton(onPressed: () {showAddCardDialog();}, child: Icon(Icons.add)),
        ],
      ),
      body: FutureBuilder(
        future: ref
            .watch(wishlistViewerControllerProvider.notifier)
            .getWishlistById(_selectedIndex!),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          w = snapshot.data!;
          return Column(
            children: [
              Text("Wishlist ${w.name}"),
              ListView.builder(
                shrinkWrap: true,
                itemCount: w.cards.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(w.cards[index]),
                    leading: Icon(Icons.card_membership),
                    onTap: () async {
                      // modify name of the card
                      String new_card_name = await showDialog(
                        context: context,
                        builder: (context) {
                          TextEditingController cardNameController =
                              TextEditingController();
                          return AlertDialog(
                            title: Text("Change card name"),
                            content: SingleChildScrollView(
                              child: TextField(
                                controller: cardNameController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: "Name of the card",
                                  icon: Icon(Icons.text_fields),
                                ),
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(
                                    context,
                                    cardNameController.text,
                                  );
                                },
                                child: Text("Validate"),
                              ),
                            ],
                          );
                        },
                      );
                      Wishlist new_wishlist = Wishlist(
                        id: w.id,
                        name: w.name,
                        cards: [
                          for (int i = 0; i < w.cards.length; i++)
                            if (i == index) new_card_name else w.cards[i],
                        ],
                      );
                      await ref
                          .read(wishlistLocalRepositoryProvider)
                          .updateWishlist(new_wishlist);
                      await ref
                          .read(wishlistViewerControllerProvider.notifier)
                          .updateWishList();
                      setState(() {});
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
