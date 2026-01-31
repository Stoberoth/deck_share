import 'package:deck_share/scryfall_searcher/presentation/widget/card_details_widget.dart';
import 'package:deck_share/share_cards/domain/share_cards_model.dart';
import 'package:deck_share/share_cards/presentation/controller/share_cards_controller.dart';
import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:deck_share/ui/molecules/molecule_dismissible.dart';
import 'package:deck_share/ui/atom/atom_list_tile.dart';
import 'package:deck_share/ui/organisms/organism_app_bar.dart';
import 'package:deck_share/ui/templates/template_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShareCardsDetailsPage extends ConsumerStatefulWidget {
  const ShareCardsDetailsPage({super.key});

  @override
  ConsumerState<ShareCardsDetailsPage> createState() =>
      _ShareCardsDetailsPageState();
}

class _ShareCardsDetailsPageState extends ConsumerState<ShareCardsDetailsPage> {
  late String _selectedIndex;
  ShareCards? currentShareCards;

  @override
  void initState() {
    super.initState();
    _selectedIndex = ref
        .read(shareCardsControllerProvider.notifier)
        .selectedItem;
    _loadShareCard();
  }

  Future<void> _loadShareCard() async {
    final shareCards = await ref
        .read(shareCardsControllerProvider.notifier)
        .getShareCardsbyId(_selectedIndex);
    setState(() {
      currentShareCards = shareCards;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentShareCards == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return BaseTemplate(
      baseAppBar: BaseAppBar(title: "Share cards details"),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BaseText(data:
                  "Lender : ",
                ),
                BaseText(data:
                  currentShareCards!.lender,
                ),
              ],
            ),

            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BaseText(data:
                  "Applicant : ",
                ),
                BaseText(data:
                  currentShareCards!.applicant,
                ),
              ],
            ),
            SizedBox(height: 30),
            Center(
              child: BaseText(data:
                "List of Cards :",
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: currentShareCards!.lendingCards.length,
                itemBuilder: (context, index) {
                  return BaseDismissible(
                    dismissibleKey: ValueKey(
                      currentShareCards!.lendingCards[index].id,
                    ),
                    onDismissed: (direction) async {
                      setState(() {
                        currentShareCards!.lendingCards.removeAt(index);
                      });
                      ShareCards updateSharecards = ShareCards(
                        lender: currentShareCards!.lender,
                        applicant: currentShareCards!.applicant,
                        lendingCards: currentShareCards!.lendingCards,
                        id: currentShareCards!.id,
                      );
                      await ref
                          .read(shareCardsControllerProvider.notifier)
                          .addShareCards(updateSharecards);
                    },
                    child: BaseListTile(
                      leading:
                          currentShareCards!.lendingCards[index].imageUris !=
                              null
                          ? Image(
                              image: Image.network(
                                currentShareCards!
                                    .lendingCards[index]
                                    .imageUris!
                                    .normal
                                    .toString(),
                              ).image,
                            )
                          :  Image(
                              image: Image.network(
                                currentShareCards!
                                    .lendingCards[index]
                                    .cardFaces![0]
                                    .imageUris!
                                    .normal
                                    .toString(),
                              ).image,),
                      title: Text(currentShareCards!.lendingCards[index].name),
                      subtitle: Text(
                        currentShareCards!.lendingCards[index].typeLine,
                      ),
                      onLongPress: () async {
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return CardDetailsWidget(
                              card: currentShareCards!.lendingCards[index],
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
