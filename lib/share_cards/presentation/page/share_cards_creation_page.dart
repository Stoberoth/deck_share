import 'package:deck_share/scryfall_searcher/presentation/page/scryfall_card_picker.dart';
import 'package:deck_share/share_cards/domain/share_cards_model.dart';
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
    return Scaffold(
      appBar: AppBar(title: Text("Create a Share Cards")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: lenderController,
                      enabled: !isChecked,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Name of the lender",
                        icon: Icon(Icons.text_fields),
                      ),
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
              TextField(
                controller: applicantController,
                enabled: isChecked,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Name of the applicant",
                  fillColor: Colors.lightBlue,
                  focusColor: Colors.lightBlue,
                  hoverColor: Colors.lightBlue,
                  icon: Icon(Icons.text_fields),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
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
                child: Text("Add Lend Card to the list"),
              ),
              widget.pickCards.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.pickCards.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(widget.pickCards[index].name),
                          onLongPress: () => setState(() {
                            widget.pickCards.removeAt(index);
                          }),
                        );
                      },
                    )
                  : Container(),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: TextButton(
        onPressed: () {
          ShareCards shareCards = ShareCards(
            id: UniqueKey().hashCode.toString(),
            lender: lenderController.text,
            applicant: applicantController.text,
            lendingCards: widget.pickCards,
          );

          Navigator.pop(context, shareCards);
        },
        child: Text("Validate"),
      ),
    );
  }
}
