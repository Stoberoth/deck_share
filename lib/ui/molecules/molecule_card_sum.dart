import 'package:deck_share/ui/atom/atom_card.dart';
import 'package:deck_share/ui/atom/atom_image.dart';
import 'package:deck_share/ui/atom/atom_list_tile.dart';
import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:deck_share/utils/app_color.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoleculeCardSum extends ConsumerWidget {
  final String image;
  final String cardName;
  final String cardExtension;

  const MoleculeCardSum({
    super.key,
    required this.image,
    required this.cardExtension,
    required this.cardName,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    return AtomCard(
      color: AppColors.surface,
      child: AtomListTile(
        leading: AtomImage(url: image),
        title: AtomText(data: cardName, fontSize: 20),
        subtitle: AtomText(
          data: cardExtension,
          fontSize: 15,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
