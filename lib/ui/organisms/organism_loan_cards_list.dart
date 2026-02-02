import 'package:deck_share/ui/atom/atom_button.dart';
import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:deck_share/ui/molecules/molecule_card_tile.dart';
import 'package:deck_share/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:scryfall_api/scryfall_api.dart';

class BaseLoanCardList extends StatefulWidget {
  final List<MtgCard>? pickCardList;

  const BaseLoanCardList({super.key, this.pickCardList});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BaseLoanCardListState();
  }
}

class _BaseLoanCardListState extends State<BaseLoanCardList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BaseText(data: "Liste des cartes", fontSize: 20),
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 300),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.pickCardList?.length,
            itemBuilder: (context, index) {
              return BaseCardTile(card: widget.pickCardList?[index]);
            },
          ),
        ),
        BaseButton(
          label: "Ajouter des cartes",
          buttonColor: AppColors.surface,
          onPressed: () {
            /* TODO : ajouts des cartes par scryfall card picker*/
          },
        ),
      ],
    );
  }
}
