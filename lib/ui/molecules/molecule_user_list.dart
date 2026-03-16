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
    return AtomCard(
      color: AppColors.primaryLight,
      child: InkWell(
        child: AtomListTile(
          title: AtomText(data: userProfile.name),
          tileColor: AppColors.primaryLight,
        ),
        onTap: () async {
          if (await ref
              .read(contactServiceProvider)
              .isAlreadyInContact(userProfile.phone!)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Duration(seconds: 1),
                content: AtomText(
                  data: "Utilisaterur déjà dans vos contact",
                  color: AppColors.error,
                ),
              ),
            );
            return;
          }
          ref
              .read(contactServiceProvider)
              .saveContact(
                Contact(
                  name: userProfile.name,
                  isRegistered: true,
                  userId: userProfile.id,
                  phone: userProfile.phone,
                ),
              );
           ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Duration(seconds: 1),
                content: AtomText(
                  data: "Utilisaterur ajouté à vos contact",
                  color: AppColors.success,
                ),
              ),
            );
        },
      ),
    );
  }
}
