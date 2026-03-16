import 'package:deck_share/contact/domain/contact_model.dart';
import 'package:deck_share/ui/atom/atom_card.dart';
import 'package:deck_share/ui/atom/atom_list_tile.dart';
import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:deck_share/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoleculeContactTile extends ConsumerWidget {
  final Contact contact;

  const MoleculeContactTile({super.key, required this.contact});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AtomCard(
      color: AppColors.surface,
      child: AtomListTile(
        tileColor: AppColors.surface,
        title: AtomText(data: contact.name, fontSize: 20,),
        subtitle: AtomText(data: contact.phone!),
      ),
    );
  }
}
