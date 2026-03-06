import 'package:deck_share/contact/application/providers/contact_providers.dart';
import 'package:deck_share/contact/domain/contact_model.dart';
import 'package:deck_share/ui/atom/atom_card.dart';
import 'package:deck_share/ui/atom/atom_list_tile.dart';
import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:deck_share/user/domain/user_model.dart';
import 'package:deck_share/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoleculeUserList extends ConsumerWidget {
  final UserProfile userProfile;

  const MoleculeUserList({super.key, required this.userProfile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      child: AtomCard(
        color: AppColors.primaryLight,
        child: AtomListTile(title: AtomText(data: userProfile.name)),
      ),
      onTap: () {
        ref
            .read(contactServiceProvider)
            .saveContact(
              Contact(
                name: userProfile.name,
                userId: userProfile.id,
                phone: userProfile.phone,
              ),
            );
      },
    );
  }
}
