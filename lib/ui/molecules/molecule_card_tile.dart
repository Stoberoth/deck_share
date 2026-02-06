import 'package:deck_share/ui/atom/atom_card.dart';
import 'package:deck_share/ui/atom/atom_image.dart';
import 'package:deck_share/ui/atom/atom_list_tile.dart';
import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:deck_share/utils/app_color.dart';
import 'package:deck_share/utils/card_image_helper.dart';
import 'package:flutter/material.dart';
import 'package:scryfall_api/scryfall_api.dart';

class MoleculeCardTile extends StatelessWidget {
  final MtgCard? card;
  final VoidCallback? onPressed;

  const MoleculeCardTile({super.key, this.card, this.onPressed});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AtomCard(
      color: AppColors.textDisabled,
      child: AtomListTile(
        title: AtomText(data: card!.name.toString(), fontSize: 20),
        leading: AtomImage(url: getCardImageUrl(card!)),
        trailing: IconButton(
          onPressed: onPressed,
          icon: Icon(Icons.close, color: AppColors.textPrimary),
        ),
        tileColor: AppColors.textDisabled,
      ),
    );
  }
}
