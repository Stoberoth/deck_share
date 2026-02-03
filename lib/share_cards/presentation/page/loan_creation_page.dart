// enfin un bouton de validation

import 'package:deck_share/scryfall_searcher/presentation/controller/scryfall_controller.dart';
import 'package:deck_share/share_cards/domain/share_cards_model.dart';
import 'package:deck_share/share_cards/presentation/controller/share_cards_controller.dart';
import 'package:deck_share/ui/atom/atom_button.dart';
import 'package:deck_share/ui/atom/atom_image.dart';
import 'package:deck_share/ui/atom/atom_list_tile.dart';
import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:deck_share/ui/atom/atom_text_field.dart';
import 'package:deck_share/ui/molecules/molecule_card_tile.dart';
import 'package:deck_share/ui/organisms/organism_app_bar.dart';
import 'package:deck_share/ui/organisms/organism_loan_cards_list.dart';
import 'package:deck_share/ui/templates/template_base.dart';
import 'package:deck_share/utils/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scryfall_api/scryfall_api.dart';

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
            // text field pour le titre du prêt

            // la liste des cartes prêter ou à prêter

            // menu de selection pour les contacts ou alors dans un premier temps juste entrer le nom

            // Date picker pour une date de rendu

            // Text field pour ajouter une note sur le prêt
            BaseTextField(
              controller: titleController,
              hintText: "Ex: Modern Burn Deck",
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

            BaseTextField(
              controller: contactController,
              hintText:
                  "Entre le nom ${amILender ? "de l'emprunteur" : "du prêteur"}",
            ),
            // TODO ajouter un bouton et un text pour le date picker
            BaseTextField(
              controller: noteController,
              hintText: "Ajouter des notes",
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
            lendingCards: ref.watch(pickcards),
          );
          ref.read(shareCardsControllerProvider.notifier).addShareCards(sc);
          Navigator.pop(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
