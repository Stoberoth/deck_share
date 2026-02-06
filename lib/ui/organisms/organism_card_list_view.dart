import 'package:deck_share/scryfall_searcher/presentation/widget/card_details_widget.dart';
import 'package:deck_share/ui/atom/atom_image.dart';
import 'package:deck_share/ui/molecules/molecule_dismissible.dart';
import 'package:deck_share/ui/atom/atom_list_tile.dart';
import 'package:deck_share/utils/card_image_helper.dart';
import 'package:flutter/material.dart';
import 'package:scryfall_api/scryfall_api.dart';

class OrganismCardListView extends StatefulWidget {
  final List<MtgCard> allCards;
  final bool? shrinkWrap;

  const OrganismCardListView({super.key, required this.allCards, this.shrinkWrap});

  @override
  State<OrganismCardListView> createState() => _OrganismCardListViewState();
}

class _OrganismCardListViewState extends State<OrganismCardListView> {
  @override
  Widget build(BuildContext context) {
    // Si la liste est vide, retourner un container vide
    if (widget.allCards.isEmpty) {
      return Container();
    }

    return ListView.builder(
      shrinkWrap: widget.shrinkWrap ?? true,
      physics: widget.shrinkWrap == true
          ? NeverScrollableScrollPhysics()
          : null,
      itemCount: widget.allCards.length,
      itemBuilder: (context, index) {
        return MoleculeDismissible(
          dismissibleKey: ValueKey(widget.allCards[index].id),
          onDismissed: (direction) {
            setState(() {
              widget.allCards.removeAt(index);
            });
          },
          child: AtomListTile(
            leading: AtomImage(url: getCardImageUrl(widget.allCards[index])),

            title: Text(widget.allCards[index].name),
            subtitle: Text(widget.allCards[index].typeLine),
            onTap: () async {
              await showDialog(
                context: context,
                builder: (context) {
                  return CardDetailsWidget(card: widget.allCards[index]);
                },
              );
            },
          ),
        );
      },
    );
  }
}
