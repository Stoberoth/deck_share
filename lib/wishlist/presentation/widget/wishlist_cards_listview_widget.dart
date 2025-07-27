import 'package:deck_share/scryfall_searcher/presentation/controller/scryfall_controller.dart';
import 'package:deck_share/scryfall_searcher/presentation/page/scryfall_card_picker.dart';
import 'package:deck_share/share_cards/domain/share_cards_model.dart';
import 'package:deck_share/share_cards/presentation/controller/share_cards_controller.dart';
import 'package:deck_share/share_cards/presentation/page/share_cards_creation_page.dart';
import 'package:deck_share/share_cards/presentation/widget/share_cards_list.dart';
import 'package:deck_share/wishlist/data/wishlist_local_repository.dart';
import 'package:deck_share/wishlist/domain/wishlist_model.dart';
import 'package:deck_share/wishlist/presentation/controller/whishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scryfall_api/scryfall_api.dart';

class CardListViewWidget extends ConsumerStatefulWidget {
  CardListViewWidget({super.key, required this.wishlist});
  Wishlist wishlist;

  @override
  ConsumerState<CardListViewWidget> createState() => _CardListViewWidgetState();
}

class _CardListViewWidgetState extends ConsumerState<CardListViewWidget> {
  late String _selectedIndex;
  List<MtgCard> pick_cards = [];
  Wishlist? currentWishlist;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex = ref
        .read(wishlistViewerControllerProvider.notifier)
        .selected!;
    _loadWishlist();
  }

  Future<void> _loadWishlist() async {
    final wishlist = await ref
        .read(wishlistViewerControllerProvider.notifier)
        .getWishlistById(_selectedIndex);
    setState(() {
      currentWishlist = wishlist;
    });
  }

  @override
  Widget build(BuildContext context) {
    //return Scaffold(
    if (currentWishlist == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: currentWishlist!.cards.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: ValueKey(currentWishlist!.cards[index].id),
                background: Container(color: Colors.red),
                onDismissed: (direction) async {
                  final card = currentWishlist!.cards[index];
                  await ref
                      .read(wishlistViewerControllerProvider.notifier)
                      .removeCardToWishlistById(currentWishlist!.id!, card);
                  setState(() {
                    currentWishlist!.cards.removeAt(index);
                  });
                },
                child: ListTile(
                  tileColor:
                      pick_cards
                          .where(
                            (element) =>
                                element.id == currentWishlist!.cards[index].id,
                          )
                          .isNotEmpty
                      ? Colors.amber
                      : Colors.white,
                  title: Text(currentWishlist!.cards[index].name),
                  subtitle: Text(currentWishlist!.cards[index].typeLine),
                  leading: currentWishlist!.cards[index].cardFaces == null
                      ? Image(
                          image: Image.network(
                            currentWishlist!.cards[index].imageUris!.normal
                                .toString(),
                          ).image,
                        )
                      : Image(
                          image: Image.network(
                            currentWishlist!
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
                              element.id == currentWishlist!.cards[index].id,
                        )
                        .isEmpty) {
                      setState(() {
                        pick_cards.add(currentWishlist!.cards[index]);
                      });
                    } else {
                      setState(() {
                        pick_cards.removeWhere(
                          (element) =>
                              element.id == currentWishlist!.cards[index].id,
                        );
                      });
                    }
                  },
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (pick_cards.isNotEmpty) {
                      ShareCards sc = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ShareCardsCreationPage(pickCards: pick_cards),
                        ),
                      );
                      await ref
                          .read(shareCardsControllerProvider.notifier)
                          .addShareCards(sc);
                    }
                  },
                  child: Text("Add to a share list selected cards"),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    List<MtgCard> card = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ScryfallCardPicker(
                            pickCards: currentWishlist!.cards,
                          );
                        },
                      ),
                    );
                    Wishlist updated_wishlist = Wishlist(
                      name: currentWishlist!.name,
                      cards: card,
                      id: currentWishlist!.id,
                    );
                    await ref
                        .read(wishlistViewerControllerProvider.notifier)
                        .updateWishlist(updated_wishlist);
                    await ref
                        .read(wishlistViewerControllerProvider.notifier)
                        .getWishList();
                    setState(() {
                      currentWishlist = updated_wishlist;
                    });
                  },
                  child: Text("Add new cards to wishlist"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
