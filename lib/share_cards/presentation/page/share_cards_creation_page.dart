import 'package:deck_share/scryfall_searcher/presentation/page/scryfall_card_picker.dart';
import 'package:deck_share/share_cards/domain/share_cards_model.dart';
import 'package:deck_share/ui/atom/atom_button.dart';
import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:deck_share/ui/atom/atom_text_field.dart';
import 'package:deck_share/ui/organisms/organism_card_list_view.dart';
import 'package:deck_share/ui/organisms/organism_app_bar.dart';
import 'package:deck_share/ui/templates/template_base.dart';
import 'package:deck_share/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scryfall_api/scryfall_api.dart';

class ShareCardsCreationPage extends ConsumerStatefulWidget {
  ShareCardsCreationPage({
    super.key,
    this.pickCards = const [],
    this.amILender = true,
  });

  final bool amILender;
  List<MtgCard> pickCards;

  @override
  ConsumerState<ShareCardsCreationPage> createState() =>
      _ShareCardsCreationPageState();
}

class _ShareCardsCreationPageState
    extends ConsumerState<ShareCardsCreationPage> {
  late TextEditingController lenderController;
  late TextEditingController applicantController;
  late TextEditingController lendCardName;
  late DateTime lendingDate; 
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    lenderController = TextEditingController();
    applicantController = TextEditingController();
    lendCardName = TextEditingController();
    isChecked = true;
    lenderController.text = "Me";
    lendingDate = DateTime.now();
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

  void _selectLendingDate() async {
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: lendingDate,
      firstDate: DateTime(2025),
      lastDate: DateTime(2026),
    );
    if (newDate != null) {
      setState(() {
        lendingDate = newDate;
      });
    }
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
              SizedBox(height: 10,),
              BaseText(data:"Lending Date : ${DateFormatter.formatDateDayMounthYear(lendingDate)}"),
              SizedBox(height: 10,),
              BaseButton(
                label: "Select Lending Date",
                onPressed: _selectLendingDate,
              ),
              SizedBox(height: 10),
              BaseButton(
                label: "Add Lend Card to the list",
                onPressed: () async {
                  widget.pickCards = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ScryfallCardPicker(),
                    ),
                  );
                  setState(() {});
                },
              ),

              widget.pickCards.isNotEmpty
                  ? CardListView(
                      allCards: widget.pickCards, 
                      shrinkWrap: true, // Hauteur maximale pour éviter les problèmes de layout
                    )
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
            lendingDate: lendingDate,
          );

          Navigator.pop(context, shareCards);
        },
      ),
    );
  }
}
