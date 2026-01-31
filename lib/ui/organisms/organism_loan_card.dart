import 'package:deck_share/share_cards/domain/share_cards_model.dart';
import 'package:deck_share/ui/atom/atom_card.dart';
import 'package:deck_share/ui/atom/atom_image.dart';
import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:deck_share/ui/atom/atom_list_tile.dart';
import 'package:deck_share/ui/molecules/molecule_shadow_image.dart';
import 'package:deck_share/utils/app_color.dart';
import 'package:flutter/material.dart';

class BaseLoanCard extends StatelessWidget {
  final BaseImage leadingImage;
  final BaseText loanTitle;
  final BaseText loanSubtitle;
  final ShareCardsStatus status;

  const BaseLoanCard({
    super.key,
    required this.leadingImage,
    required this.loanTitle,
    required this.loanSubtitle,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor = (status == ShareCardsStatus.active
        ? AppColors.success
        : AppColors.warning);
    return BaseCard(
      child: BaseListTile(
        leading: BaseShadowImage(image: leadingImage, color: statusColor),
        title: loanTitle,
        subtitle: loanSubtitle,
        trailing: 
            Icon(Icons.arrow_forward_ios, color: statusColor,),
        ),
    );
  }
}
