import 'package:flutter/material.dart';
import 'package:scryfall_api/scryfall_api.dart';

class CardDetails_widget extends StatelessWidget {
  const CardDetails_widget({super.key, required this.card});

  final MtgCard card;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image(
                image: card.cardFaces == null
                    ? Image.network(card.imageUris!.normal.toString()).image
                    : Image.network(
                        card.cardFaces![0].imageUris!.normal.toString(),
                      ).image,

              ),
              SizedBox(height: 10),
              card.cardFaces != null
                  ? Column(
                      children: [
                        Text(
                          card.cardFaces![0].name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(card.cardFaces![0].oracleText!),
                        SizedBox(height: 10),
                        Text(
                          card.cardFaces![1].name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(card.cardFaces![1].oracleText!),
                      ],
                    )
                  : Column(
                      children: [
                        Text(
                          card.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(card.oracleText!),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
