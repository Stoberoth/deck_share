import 'package:deck_share/share_cards/domain/share_cards_model.dart';
import 'package:deck_share/share_cards/presentation/controller/share_cards_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShareCardsCreationPage extends ConsumerStatefulWidget {
  const ShareCardsCreationPage({super.key});

  @override
  ConsumerState<ShareCardsCreationPage> createState() =>
      _ShareCardsCreationPageState();
}

class _ShareCardsCreationPageState
    extends ConsumerState<ShareCardsCreationPage> {
  late TextEditingController lenderController;
  late TextEditingController applicantController;
  late TextEditingController lendCardName;
  List<String> lendCards = [];
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    lenderController = TextEditingController();
    applicantController = TextEditingController();
    lendCardName = TextEditingController();
    isChecked = true;
    lenderController.text = "Me";
  }

  @override
  void dispose() {
    lenderController.dispose();
    applicantController.dispose();
    lendCardName.dispose();
    super.dispose();
  }

  void addLendCards(String cardName) {
    if (cardName.isEmpty) {
      return;
    } else {
      setState(() {
        lendCards.add(cardName);
        lendCardName.clear();
      });
    }
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
                  Expanded( child: TextField(
                    controller: lenderController,
                    enabled: !isChecked,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Name of the lender",
                      icon: Icon(Icons.text_fields),
                    ),
                  ),),
                  Checkbox(
                    value: isChecked,
                    checkColor: Colors.black,
                    onChanged: (newValue) {
                      setState(() {
                        isChecked = newValue!;
                        if (isChecked!){
                          lenderController.text = "Me";
                          applicantController.clear();
                        }
                        else {
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
                  icon: Icon(Icons.text_fields),
                ),
              ),
              TextField(
                controller: lendCardName,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Name of lend Card",
                  icon: Icon(Icons.text_fields),
                ),
              ),
              TextButton(
                onPressed: () {
                  addLendCards(lendCardName.text);
                  setState(() {});
                },
                child: Text("Add Lend Card to the list"),
              ),
              if (lendCards.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: lendCards.length,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text(lendCards[index]));
                  },
                ),
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
            lendingCards: lendCards,
          );

          Navigator.pop(context, shareCards);
        },
        child: Text("Validate"),
      ),
    );
  }
}
