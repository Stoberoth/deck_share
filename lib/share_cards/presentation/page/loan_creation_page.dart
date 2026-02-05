// enfin un bouton de validation

import 'package:deck_share/share_cards/domain/share_cards_model.dart';
import 'package:deck_share/ui/atom/atom_button.dart';
import 'package:deck_share/ui/atom/atom_card.dart';
import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:deck_share/ui/atom/atom_text_field.dart';
import 'package:deck_share/ui/molecules/molecule_date_picker.dart';
import 'package:deck_share/ui/organisms/organism_app_bar.dart';
import 'package:deck_share/ui/organisms/organism_loan_cards_list.dart';
import 'package:deck_share/ui/templates/template_base.dart';
import 'package:deck_share/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoanCreationPage extends ConsumerStatefulWidget {
  const LoanCreationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoanCreationState();
}

class _LoanCreationState extends ConsumerState<LoanCreationPage> {
  bool amILender = true;

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController contactController = TextEditingController();
    TextEditingController noteController = TextEditingController();
    return BaseTemplate(
      baseAppBar: BaseAppBar(title: "Nouveau prêt"),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            BaseTextField(
              controller: titleController,
              hintText: "Ex: Modern Burn Deck",
              textColor: Colors.black,
            ),
            // leading l'image de la carte (la crop image je pense)
            // en title le nom de la carte et en trailing de quoi la supprimer de la liste
            BaseLoanCardList(),
            SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: amILender,
                  onChanged: (value) {
                    setState(() {
                      amILender = value!;
                    });
                  },
                ),
                BaseText(data: "Je prête", color: Colors.black, fontSize: 20),
              ],
            ),

            BaseCard(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsetsGeometry.all(10),
                child: BaseTextField(
                  controller: contactController,
                  hintText:
                      "Entrez le nom ${amILender ? "de l'emprunteur" : "du prêteur"}",
                      textColor: Colors.black,
                ),
              ),
            ),
            BaseDatePicker(),
            BaseCard(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsetsGeometry.all(10),
                child: BaseTextField(
                  controller: noteController,
                  hintText: "Ajouter des notes",
                  textColor: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: BaseButton(
        label: "Créer le prêt",
        buttonColor: AppColors.surface,
        onPressed: () {
          // Create a new share cards
          ShareCards sc = ShareCards(
            id: UniqueKey().hashCode.toString(),
            status: ShareCardsStatus.active,
            title: titleController.text,
            lender: amILender ? "Me" : contactController.text,
            applicant: !amILender ? "Me" : contactController.text,
            lendingCards: ref.read(pickcards).toList(),
            expectedReturnDate: ref.read(selectDate),
            lendingDate: DateTime.now(),
            notes: noteController.text,
          );
          ref.read(pickcards.notifier).state.clear();
          // Retourner le ShareCards à la page parente qui gère l'ajout
          Navigator.pop(context, sc);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
