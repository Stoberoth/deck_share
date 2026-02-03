import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:deck_share/ui/molecules/molecule_loan_sum.dart';
import 'package:deck_share/ui/organisms/organism_app_bar.dart';
import 'package:deck_share/ui/templates/template_base.dart';
import 'package:deck_share/ui/templates/template_loan_list.dart';
import 'package:deck_share/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoanDetailsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseTemplate(
      baseAppBar: BaseAppBar(title: "Details du prêt"),
      backgroundColor: AppColors.background,
      body: BaseLoanSum(),
      // Card ou container avec le titre du prêt
      // Un encart pour savoir si le prêt est en cours
      // qui emprunt/prête les cartes
      // la date de l'emprunt
      // quand le retour est précu
      // depuis combien de temps l'emprunt cour

      // en dessous les cartes prêtéses sous forme de liste avec:
      // - l'image de la carte
      // - le nom de la carte
      // - l'extension
    );
  }
}
