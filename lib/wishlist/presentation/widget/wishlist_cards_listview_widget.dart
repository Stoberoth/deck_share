import 'package:deck_share/share_cards/presentation/page/share_cards_creation_page.dart';
import 'package:deck_share/share_cards/presentation/widget/share_cards_list.dart';
import 'package:deck_share/wishlist/data/wishlist_local_repository.dart';
import 'package:deck_share/wishlist/domain/wishlist_model.dart';
import 'package:deck_share/wishlist/presentation/controller/whishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scryfall_api/scryfall_api.dart';

class CardListViewWidget extends ConsumerStatefulWidget {
  const CardListViewWidget({super.key});

  @override
  ConsumerState<CardListViewWidget> createState() => _CardListViewWidgetState();
}

class _CardListViewWidgetState extends ConsumerState<CardListViewWidget> {
  late String _selectedIndex;
  List<MtgCard> pick_cards = [];

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
    //return Scaffold(
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
                return Dismissible(
                  key: ValueKey(index),
                  background: Container(color: Colors.red),
                  onDismissed: (direction) async {
                    await ref
                        .read(wishlistViewerControllerProvider.notifier)
                        .removeCardToWishlistById(
                          currentWishlist.id!,
                          currentWishlist.cards[index],
                        );
                    setState(() {});
                  },
                  child: ListTile(
                    tileColor:
                        pick_cards
                            .where(
                              (element) =>
                                  element.id == currentWishlist.cards[index].id,
                            )
                            .isNotEmpty
                        ? Colors.amber
                        : Colors.white,
                    title: Text(currentWishlist.cards[index].name),
                    subtitle: Text(currentWishlist.cards[index].typeLine),
                    leading: currentWishlist.cards[index].cardFaces == null
                        ? Image(
                            image: Image.network(
                              currentWishlist.cards[index].imageUris!.normal
                                  .toString(),
                            ).image,
                          )
                        : Image(
                            image: Image.network(
                              currentWishlist
                                  .cards[index]
                                  .cardFaces![0]
                                  .imageUris!
                                  .normal
                                  .toString(),
                            ).image,
                          ),
                    onTap: () {
                      if (pick_cards
                          .where(
                            (element) =>
                                element.id == currentWishlist.cards[index].id,
                          )
                          .isEmpty) {
                        setState(() {
                          pick_cards.add(currentWishlist.cards[index]);
                        });
                      } else {
                        setState(() {
                          pick_cards.removeWhere(
                            (element) =>
                                element.id == currentWishlist.cards[index].id,
                          );
                        });
                      }
                    },
                  ),
                );
              },
            );
          }
        },
      
    );
  }
}
