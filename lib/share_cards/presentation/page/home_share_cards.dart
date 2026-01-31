import 'dart:io';

import 'package:deck_share/share_cards/domain/share_cards_model.dart';
import 'package:deck_share/share_cards/presentation/controller/share_cards_controller.dart';
import 'package:deck_share/share_cards/presentation/page/share_cards_creation_page.dart';
import 'package:deck_share/ui/atom/atom_card.dart';
import 'package:deck_share/ui/atom/atom_floating_action_button.dart';
import 'package:deck_share/ui/atom/atom_image.dart';
import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:deck_share/ui/molecules/molecule_slider_segmented_button.dart';
import 'package:deck_share/ui/organisms/organism_app_bar.dart';
import 'package:deck_share/ui/organisms/organism_loan_card.dart';
import 'package:deck_share/ui/templates/template_base.dart';
import 'package:deck_share/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Page to create a share cards
///

class ShareCardsPage extends ConsumerStatefulWidget {
  const ShareCardsPage({super.key});

  @override
  ConsumerState<ShareCardsPage> createState() => _ShareCardsPageState();
}

class _ShareCardsPageState extends ConsumerState<ShareCardsPage> {
  String value = "pret";
  int? groupValue = 0;
  @override
  Widget build(BuildContext context) {
    return BaseTemplate(
      baseAppBar: BaseAppBar(title: 'Mes Prêts'),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                /*2 container avec icons de prêt et icon de d'emprunt*/
                Expanded(
                  child: BaseCard(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 15),
                        Icon(
                          Icons.volunteer_activism,
                          size: 50,
                          color: AppColors.primary,
                        ),
                        SizedBox(height: 10),
                        BaseText(data: "Prêts actifs : 4"),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: BaseCard(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 15),
                        Icon(
                          Icons.front_hand,
                          size: 50,
                          color: AppColors.primary,
                        ),
                        SizedBox(height: 10),
                        BaseText(data: "Emprunts actifs : 2"),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            BaseSliderSegmentedButton(),
            /*ShareCardsListWidget()*/

            Row(
              children: [
                Expanded(
                  child: BaseLoanCard(
                    leadingImage: BaseImage(
                      url:
                          "https://assets.moxfield.net/cards/card-7RMxd-normal.webp?269928852",
                    ),
                    loanTitle: BaseText(
                      data: "The wandering minstrel",
                      fontSize: 15,
                    ),
                    loanSubtitle: BaseText(data: "sub"),
                    status: ShareCardsStatus.active,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: BaseFloatingActionButton(
        child: Icon(Icons.add, color: AppColors.textPrimary),
        onPressed: () async {
          ShareCards? sc = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ShareCardsCreationPage(pickCards: [], amILender: true),
            ),
          );
          if (sc != null) {
            await ref
                .read(shareCardsControllerProvider.notifier)
                .addShareCards(sc);
          }
        },
      ),
    );
  }
}

Widget buildSegment(String text) => Container(
  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20), // Arrondi personnalisé
  ),
  child: BaseText(data: text),
);
