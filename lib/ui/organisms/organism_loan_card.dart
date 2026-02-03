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
  final Widget loanSubtitle;
  final bool isOverdue;

  const BaseLoanCard({
    super.key,
    required this.leadingImage,
    required this.loanTitle,
    required this.loanSubtitle,
    required this.isOverdue,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor = (isOverdue
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
