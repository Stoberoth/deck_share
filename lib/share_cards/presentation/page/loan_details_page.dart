import 'package:deck_share/share_cards/domain/share_cards_model.dart';
import 'package:deck_share/share_cards/presentation/controller/share_cards_controller.dart';
import 'package:deck_share/ui/atom/atom_button.dart';
import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:deck_share/ui/molecules/molecule_loan_sum.dart';
import 'package:deck_share/ui/molecules/molecule_notes.dart';
import 'package:deck_share/ui/molecules/molecule_slider_segmented_button.dart';
import 'package:deck_share/ui/organisms/organism_app_bar.dart';
import 'package:deck_share/ui/organisms/organism_card_sum_list.dart';
import 'package:deck_share/ui/templates/template_base.dart';
import 'package:deck_share/ui/templates/template_loan_list.dart';
import 'package:deck_share/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoanDetailsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ShareCards loanToSum = ref.read(selectLoan);
    return TemplateBase(
      baseAppBar: OrganismAppBar(title: "Details du prêt"),
      backgroundColor: AppColors.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MoleculeLoanSum(),
          SizedBox(height: 5),
          AtomText(
            data: "Cartes prêtées (${loanToSum.lendingCards.length})",
            fontSize: 20,
          ),
          ?loanToSum.lendingCards.isNotEmpty ? OrganismCardSumList() : null,

          // Container pour les notes
          loanToSum.notes != "" ? MoleculeNotes() : Container(),
        ],
      ),
      bottomNavBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.primary, width: 1.0)),
        ),
        child: BottomAppBar(
          color: AppColors.background,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () async {
                  await ref
                      .read(shareCardsControllerProvider.notifier)
                      .markAsReturned(loanToSum.id!, ref.watch(indexProvider));
                  Navigator.pop(context, true);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.success,
                ),
                child: Row(
                  children: [
                    Icon(Icons.check),
                    AtomText(data: "Marquer comme rendu", fontSize: 15),
                  ],
                ),
              ),
              //BaseButton(label: "Marquer comme rendu", onPressed: () {}),
              Spacer(),
              AtomButton(
                label: "Prolonger",
                onPressed: () async {
                  DateTime? newReturnDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );
                  if (newReturnDate != null) {
                    await ref
                        .read(shareCardsControllerProvider.notifier)
                        .extendLoan(loanToSum.id!, newReturnDate, ref.watch(indexProvider));
                    Navigator.pop(context, true);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
