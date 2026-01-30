import 'package:deck_share/scryfall_searcher/presentation/widget/card_details_widget.dart';
import 'package:deck_share/ui/atom/base_image.dart';
import 'package:deck_share/ui/molecules/base_dismissible.dart';
import 'package:deck_share/ui/molecules/base_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:scryfall_api/scryfall_api.dart';

class CardListView extends StatefulWidget {
  final List<MtgCard> allCards;
  final bool? shrinkWrap;

  const CardListView({super.key, required this.allCards, this.shrinkWrap});

  @override
  State<CardListView> createState() => _CardListViewState();
}

class _CardListViewState extends State<CardListView> {
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
        return BaseDismissible(
          dismissibleKey: ValueKey(widget.allCards[index].id),
          onDismissed: (direction) {
            setState(() {
              widget.allCards.removeAt(index);
            });
          },
          child: BaseListTile(
            leading:
                widget.allCards[index].cardFaces != null &&
                    widget.allCards[index].cardFaces!.length > 1
                ? BaseImage(
                    url: widget.allCards[index].cardFaces![0].imageUris!.normal
                        .toString(),
                  )
                : BaseImage(
                    url: widget.allCards[index].imageUris!.normal.toString(),
                  ),
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
