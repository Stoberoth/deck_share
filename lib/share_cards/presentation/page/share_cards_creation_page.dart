import 'package:deck_share/scryfall_searcher/presentation/page/scryfall_card_picker.dart';
import 'package:deck_share/scryfall_searcher/presentation/widget/card_details_widget.dart';
import 'package:deck_share/share_cards/domain/share_cards_model.dart';
import 'package:deck_share/ui/atom/base_button.dart';
import 'package:deck_share/ui/atom/base_dismissible.dart';
import 'package:deck_share/ui/atom/base_floating_action_button.dart';
import 'package:deck_share/ui/atom/base_list_tile.dart';
import 'package:deck_share/ui/atom/base_text_field.dart';
import 'package:deck_share/ui/molecules/card_list_view.dart';
import 'package:deck_share/ui/organisms/base_app_bar.dart';
import 'package:deck_share/ui/templates/base_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scryfall_api/scryfall_api.dart';

class ShareCardsCreationPage extends ConsumerStatefulWidget {
  ShareCardsCreationPage({
    super.key,
    required this.pickCards,
    required this.amILender,
  });

  bool amILender = true;
  List<MtgCard> pickCards = [];

  @override
  ConsumerState<ShareCardsCreationPage> createState() =>
      _ShareCardsCreationPageState();
}

class _ShareCardsCreationPageState
    extends ConsumerState<ShareCardsCreationPage> {
  late TextEditingController lenderController;
  late TextEditingController applicantController;
  late TextEditingController lendCardName;
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    lenderController = TextEditingController();
    applicantController = TextEditingController();
    lendCardName = TextEditingController();
    isChecked = true;
    lenderController.text = "Me";
    isChecked = widget.amILender;
    if (isChecked) {
      lenderController.text = "Me";
      applicantController.clear();
    } else {
      lenderController.clear();
      applicantController.text = "Me";
    }
  }

  @override
  void dispose() {
    lenderController.dispose();
    applicantController.dispose();
    lendCardName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseTemplate(
      baseAppBar: BaseAppBar(title: "Create a Share Cards"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: BaseTextField(
                      controller: lenderController,
                      hintText: "Name of the lender",
                      icon: Icon(Icons.text_fields),
                      enabled: !isChecked,
                    ),
                  ),
                  Checkbox(
                    value: isChecked,
                    checkColor: Colors.black,
                    onChanged: (newValue) {
                      setState(() {
                        isChecked = newValue!;
                        if (isChecked) {
                          lenderController.text = "Me";
                          applicantController.clear();
                        } else {
                          lenderController.clear();
                          applicantController.text = "Me";
                        }
                      });
                    },
                  ),
                ],
              ),
              BaseTextField(
                controller: applicantController,
                hintText: "Name of the applicant",
                icon: Icon(Icons.text_fields),
                enabled: isChecked,
              ),

              SizedBox(height: 10),
              BaseButton(
                label: "Add Lend Card to the list",
                onPressed: () async {
                  widget.pickCards = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ScryfallCardPicker(pickCards: widget.pickCards),
                    ),
                  );
                  setState(() {});
                },
              ),

              widget.pickCards.isNotEmpty
                  ? CardListView(allCards: widget.pickCards, shrinkWrap: true,)
                  : Container(),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BaseButton(
        label: "Validate",
        onPressed: () {
          ShareCards shareCards = ShareCards(
            id: UniqueKey().hashCode.toString(),
            lender: lenderController.text,
            applicant: applicantController.text,
            lendingCards: widget.pickCards,
          );

          Navigator.pop(context, shareCards);
        },
      ),
    );
  }
}
