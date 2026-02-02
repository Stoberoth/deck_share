import 'package:deck_share/ui/atom/atom_card.dart';
import 'package:deck_share/ui/atom/atom_image.dart';
import 'package:deck_share/ui/atom/atom_list_tile.dart';
import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:deck_share/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:scryfall_api/scryfall_api.dart';

class BaseCardTile extends StatelessWidget {
  final MtgCard? card;
  const BaseCardTile({super.key, this.card});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BaseCard(
      color: AppColors.textDisabled,
      child: BaseListTile(
        title: BaseText(data: card!.name.toString(), fontSize: 20),
        leading: BaseImage(url: card!.imageUris!.artCrop.toString()),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(Icons.close, color: AppColors.textPrimary),
        ),
        tileColor: AppColors.textDisabled,
      ),
    );
  }
}
