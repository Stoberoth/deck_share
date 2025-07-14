import 'package:deck_share/wishlist/data/wishlist_local_repository.dart';
import 'package:deck_share/wishlist/domain/wishlist_model.dart';
import 'package:deck_share/wishlist/presentation/controller/whishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardListViewWidget extends ConsumerStatefulWidget {
  const CardListViewWidget({super.key});

  @override
  ConsumerState<CardListViewWidget> createState() => _CardListViewWidgetState();
}

class _CardListViewWidgetState extends ConsumerState<CardListViewWidget> {
  late String _selectedIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex = ref
        .read(wishlistViewerControllerProvider.notifier)
        .selected!;
  }

  @override
  Widget build(BuildContext context) {
    late Wishlist currentWishlist;
    return FutureBuilder(
      future: ref
          .read(wishlistViewerControllerProvider.notifier)
          .getWishlistById(_selectedIndex),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        } else {
          currentWishlist = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: currentWishlist.cards.length,
            itemBuilder: (context, index) {
              return ListTile(
                tileColor: Colors.amber,
                title: Text(currentWishlist.cards[index]),
                leading: Icon(Icons.card_giftcard),
                onLongPress: () async {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Delete selected card"),
                        content: TextButton(
                          onPressed: () async {
                            await ref
                                .read(wishlistViewerControllerProvider.notifier)
                                .removeCardToWishlistById(
                                  currentWishlist.id!,
                                  currentWishlist.cards[index],
                                );
                            setState(() {});
                            //removeCard(w.cards[index]);
                            Navigator.pop(context);
                          },
                          child: Text("Delete"),
                        ),
                      );
                    },
                  );
                },
                onTap: () async{
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
                        id: currentWishlist.id,
                        name: currentWishlist.name,
                        cards: [
                          for (int i = 0; i < currentWishlist.cards.length; i++)
                            if (i == index) new_card_name else currentWishlist.cards[i],
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
          );
        }
      },
    );
  }
}
