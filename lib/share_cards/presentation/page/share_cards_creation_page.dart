import 'package:deck_share/share_cards/domain/share_cards_model.dart';
import 'package:deck_share/share_cards/presentation/controller/share_cards_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShareCardsCreationPage extends ConsumerWidget {
  const ShareCardsCreationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController lenderController = TextEditingController();
    TextEditingController applicantController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text("Create a Share Cards")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: lenderController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Name of the lender",
                  icon: Icon(Icons.text_fields),
                ),
              ),
              TextField(
                controller: applicantController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Name of the applicant",
                  icon: Icon(Icons.text_fields),
                ),
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
            lendingCards: [],
          );
          
          Navigator.pop(context, shareCards);
        },
        child: Text("Validate"),
      ),
    );
  }
}
