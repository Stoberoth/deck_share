import 'package:deck_share/scryfall_searcher/presentation/widget/card_details_widget.dart';
import 'package:deck_share/ui/atom/base_dismissible.dart';
import 'package:deck_share/ui/atom/base_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:scryfall_api/scryfall_api.dart';

class CardListView extends StatefulWidget {
  final List<MtgCard> allCards;
  final bool? shrinkWrap;

  CardListView({super.key, required this.allCards, this.shrinkWrap});

  @override
  State<CardListView> createState() => _CardListViewState();
}

class _CardListViewState extends State<CardListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: widget.shrinkWrap != null ? widget.shrinkWrap! : false,
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
            leading: widget.allCards[index].imageUris != null
                ? Image(
                    image: Image.network(
                      widget.allCards[index].imageUris!.normal.toString(),
                    ).image,
                  )
                : Container(),
            title: Text(widget.allCards[index].name),
            subtitle: Text(widget.allCards[index].typeLine),
            onTap: () async {
              await showDialog(
                context: context,
                builder: (context) {
                  return CardDetails_widget(card: widget.allCards[index]);
                },
              );
            },
          ),
        );
      },
    );
  }
}
