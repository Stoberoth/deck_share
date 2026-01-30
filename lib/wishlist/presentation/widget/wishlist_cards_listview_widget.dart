import 'package:deck_share/scryfall_searcher/presentation/page/scryfall_card_picker.dart';
import 'package:deck_share/share_cards/domain/share_cards_model.dart';
import 'package:deck_share/share_cards/presentation/controller/share_cards_controller.dart';
import 'package:deck_share/share_cards/presentation/page/share_cards_creation_page.dart';
import 'package:deck_share/ui/atom/base_button.dart';
import 'package:deck_share/ui/molecules/base_dismissible.dart';
import 'package:deck_share/ui/molecules/base_list_tile.dart';
import 'package:deck_share/wishlist/domain/wishlist_model.dart';
import 'package:deck_share/wishlist/presentation/controller/whishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scryfall_api/scryfall_api.dart';

class CardListViewWidget extends ConsumerStatefulWidget {
  const CardListViewWidget({super.key, required this.wishlist});
  final Wishlist wishlist;

  @override
  ConsumerState<CardListViewWidget> createState() => _CardListViewWidgetState();
}

class _CardListViewWidgetState extends ConsumerState<CardListViewWidget> {
  late String _selectedIndex;
  List<MtgCard> pickCards = [];
  Wishlist? currentWishlist;

  @override
  void initState() {
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

  String? _isInShareList(String id) {
    List<ShareCards>? allShareCards = ref
        .watch(shareCardsControllerProvider)
        .value;
    if (allShareCards == null) {
      return null;
    }
    for (ShareCards c in allShareCards) {
      if (c.lendingCards.where((element) => element.id == id).isNotEmpty &&
          c.applicant == "Me") {
        return c.lender.isNotEmpty ? c.lender : "";
      }
    }
    return null;
  }

  bool alreadyShare() {
    List<ShareCards>? allShareCards = ref
        .watch(shareCardsControllerProvider)
        .value;
    if (allShareCards == null) {
      return false;
    }
    for (ShareCards s in allShareCards) {
      for (MtgCard c in pickCards) {
        if (s.lendingCards.where((element) => element.id == c.id).isNotEmpty &&
            s.applicant == "Me") {
          return true;
        }
      }
    }
    return false;
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
              return BaseDismissible(
                dismissibleKey: ValueKey(currentWishlist!.cards[index].id),
                onDismissed: (direction) async {
                  final card = currentWishlist!.cards[index];
                  await ref
                      .read(wishlistViewerControllerProvider.notifier)
                      .removeCardToWishlistById(currentWishlist!.id!, card);
                  setState(() {
                    currentWishlist!.cards.removeAt(index);
                  });
                },
                child: BaseListTile(
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
                  title: Text(currentWishlist!.cards[index].name),
                  subtitle: Text(currentWishlist!.cards[index].typeLine),
                  trailing: Text(_isInShareList(currentWishlist!.cards[index].id) != null ? _isInShareList(currentWishlist!.cards[index].id)! : ""),
                  tileColor:
                      pickCards
                          .where(
                            (element) =>
                                element.id == currentWishlist!.cards[index].id,
                          )
                          .isNotEmpty
                      ? Colors.amber
                      : Colors.white,
                  onTap: () {
                    if (pickCards
                        .where(
                          (element) =>
                              element.id == currentWishlist!.cards[index].id,
                        )
                        .isEmpty) {
                      setState(() {
                        pickCards.add(currentWishlist!.cards[index]);
                      });
                    } else {
                      setState(() {
                        pickCards.removeWhere(
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
                child: BaseButton(
                  label: "Add to a share list selected cards",
                  onPressed: () async {
                    if (alreadyShare()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Some selected cards seems to be already shared with you",
                          ),
                        ),
                      );
                    } else if (pickCards.isNotEmpty) {
                      ShareCards sc = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShareCardsCreationPage(
                            pickCards: pickCards,
                            amILender: false,
                          ),
                        ),
                      );
                      await ref
                          .read(shareCardsControllerProvider.notifier)
                          .addShareCards(sc);
                      pickCards.clear();
                    }
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: BaseButton(
                  label: "Add new cards to wishlist",
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
                    Wishlist updatedWishlist = Wishlist(
                      name: currentWishlist!.name,
                      cards: card,
                      id: currentWishlist!.id,
                    );
                    await ref
                        .read(wishlistViewerControllerProvider.notifier)
                        .updateWishlist(updatedWishlist);
                    await ref
                        .read(wishlistViewerControllerProvider.notifier)
                        .getWishList();
                    setState(() {
                      currentWishlist = updatedWishlist;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
