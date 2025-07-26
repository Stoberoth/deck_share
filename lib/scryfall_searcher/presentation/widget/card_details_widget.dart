import 'package:deck_share/scryfall_searcher/presentation/controller/scryfall_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scryfall_api/scryfall_api.dart';

class Ruling_widget extends ConsumerWidget {
  final String card_id;

  const Ruling_widget({super.key, required this.card_id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref
          .read(scryfallControllerProvider.notifier)
          .getRulingById(card_id),
      builder: (context, snapshot) {

        if (!snapshot.hasData || snapshot.data!.isEmpty) return Container();
        List<Widget> rules = snapshot.data!
            .map<Widget>(
              (ruling) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(ruling.comment),
                  Divider(color: Colors.black),
                ],
              ),
            )
            .toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Rulings : ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            ...rules,
          ],
        );
      },
    );
  }
}

class CardDetails_widget extends StatefulWidget {
  const CardDetails_widget({super.key, required this.card});

  final MtgCard card;

  @override
  State<CardDetails_widget> createState() => _CardDetails_widgetState();
}

class _CardDetails_widgetState extends State<CardDetails_widget> {
  int current_face = 0;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    if (widget.card.layout == Layout.flip ||
                        widget.card.layout == Layout.modalDfc ||
                        widget.card.layout == Layout.doubleFacedToken ||
                        widget.card.layout == Layout.meld ||
                        widget.card.layout == Layout.battle ||
                        widget.card.layout == Layout.transform ||
                        (widget.card.layout == Layout.saga)) {
                      current_face++;
                      current_face %= 2;
                    }
                  });
                },
                child: Image(
                  image: widget.card.cardFaces == null
                      ? Image.network(
                          widget.card.imageUris!.normal.toString(),
                        ).image
                      : Image.network(
                          widget.card.cardFaces![current_face].imageUris!.normal
                              .toString(),
                        ).image,
                ),
              ),

              SizedBox(height: 10),
              widget.card.cardFaces != null
                  ? Column(
                      children: [
                        Text(
                          widget.card.cardFaces![0].name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(widget.card.cardFaces![0].oracleText!),
                        SizedBox(height: 10),
                        Text(
                          widget.card.cardFaces![1].name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(widget.card.cardFaces![1].oracleText!),
                      ],
                    )
                  : Column(
                      children: [
                        Text(
                          widget.card.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(widget.card.oracleText!),
                      ],
                    ),
              SizedBox(height: 10),
              Ruling_widget(card_id: widget.card.id),
            ],
          ),
        ),
      ),
    );
  }
}
