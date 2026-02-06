import 'package:deck_share/scryfall_searcher/presentation/controller/scryfall_controller.dart';
import 'package:deck_share/ui/atom/atom_button.dart';
import 'package:deck_share/ui/atom/atom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scryfall_api/scryfall_api.dart';

class ScryfallOptionDialog extends ConsumerWidget {
  ScryfallOptionDialog({super.key, required this.optionsText});
  Map<String, String> optionsText;

  // la langue de recherche
  // le CCM
  // le type de carte
  // la couleur / identité de couleur de la carte
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> Rarity = ["Common", "Uncommon", "Rare", "Mythic", "Special"];
    List<String> Type = [
      "Creature",
      "Enchantment",
      "Instant",
      "Sorcery",
      "Artifact",
      "Land",
      "Plane",
      "Battle",
      "Snow",
      "Ongoing",
    ];
    TextEditingController setSearchController = TextEditingController();
    TextEditingController rarityController = TextEditingController();
    TextEditingController typeController = TextEditingController();
    return FutureBuilder(
      future: ref.read(scryfallControllerProvider.notifier).getAllSets(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return AlertDialog(
          title: AtomText(data: "Add search options"),
          content: Column(
            children: [
              Row(
                children: [
                  AtomText(data: "Sets"),
                  SizedBox(width: 10),
                  DropdownMenu(
                    textStyle: TextStyle(fontSize: 20),
                    controller: setSearchController,
                    dropdownMenuEntries: snapshot.data!,
                    requestFocusOnTap: true,
                    enableFilter: true,
                    menuHeight: 200,
                    //initialSelection: snapshot.data!.firstWhere((element) => element.value.code == optionsText["e:"]).value,
                    width: 200,
                    onSelected: (value) {
                      optionsText["e:"] = (value!).code;
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  AtomText(data: "Rarity"),
                  SizedBox(width: 10),
                  DropdownMenu(
                    textStyle: TextStyle(fontSize: 20),
                    controller: rarityController,
                    dropdownMenuEntries: Rarity.map(
                      (e) => DropdownMenuEntry(value: e, label: e),
                    ).toList(),
                    initialSelection: optionsText["rarity:"],
                    onSelected: (value) {
                      optionsText["rarity:"] = "${rarityController.text}";
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  AtomText(data: "Type"),
                  SizedBox(width: 10),
                  DropdownMenu(
                    textStyle: TextStyle(fontSize: 20),
                    controller: typeController,
                    dropdownMenuEntries: Type.map((e) => DropdownMenuEntry(value: e, label: e)).toList(),
                    initialSelection: optionsText["t:"],
                    onSelected: (value) {
                      optionsText["t:"] = "${typeController.text}";
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: [
            AtomButton(
              label: "Validate options",
              onPressed: () {
                Navigator.pop(context, optionsText);
              },
            ),
            AtomButton(
              label: "Clear options",
              onPressed: () {
                optionsText = {};
                setSearchController.clear();
                rarityController.clear();
                typeController.clear();
              },
            ),
          ],
        );
      },
    );
  }
}
