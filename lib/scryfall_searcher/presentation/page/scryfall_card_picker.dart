import 'package:deck_share/scryfall_searcher/presentation/controller/scryfall_controller.dart';
import 'package:deck_share/scryfall_searcher/presentation/page/scryfall_search_options_dialog.dart';
import 'package:deck_share/scryfall_searcher/presentation/widget/card_details_widget.dart';
import 'package:deck_share/ui/atom/atom_button.dart';
import 'package:deck_share/ui/atom/atom_text_field.dart';
import 'package:deck_share/ui/organisms/organism_app_bar.dart';
import 'package:deck_share/ui/templates/template_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scryfall_api/scryfall_api.dart';

/// A page the will show all the cards we want to search and permit to pick them to add them to a wishlist or a share list

// ignore: must_be_immutable
class ScryfallCardPicker extends ConsumerStatefulWidget {
  List<MtgCard> pickCards = [];
  ScryfallCardPicker({super.key, required this.pickCards});

  @override
  ConsumerState<ScryfallCardPicker> createState() => _ScryfallCardPickerState();
}

class _ScryfallCardPickerState extends ConsumerState<ScryfallCardPicker> {
  MtgSet? selectedSet;

  Map<String, String> optionText = {};

  TextEditingController searchController = TextEditingController();
  TextEditingController searchOracleController = TextEditingController();
  TextEditingController setSearchController = TextEditingController();

  void onSearch() async {
    try {
      await ref
          .read(scryfallControllerProvider.notifier)
          .searchCards(
            cardName: searchController.text,
            setCode: selectedSet?.code,
            oracleText: searchOracleController.text,
            optionsText: optionText,
          );
    } on ScryfallException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erreur Scryfall : ${e.details}")));
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    searchOracleController.dispose();
    setSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<MtgCard>> listOfCards = ref.watch(
      scryfallControllerProvider,
    );

    return BaseTemplate(
      baseAppBar: BaseAppBar(title: "Search for cards"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: ref.read(scryfallControllerProvider.notifier).getAllSets(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return Column(
                children: [
                  BaseTextField(
                    controller: searchController,
                    hintText: "Search Card by name",
                    icon: Icon(Icons.search),
                    onSubmitted: (value) => onSearch(),
                  ),
                  SizedBox(height: 10),
                  BaseTextField(
                    controller: searchOracleController,
                    hintText: "Search card by oracle text",
                    icon: Icon(Icons.search),
                    onSubmitted: (value) => onSearch(),
                  ),

                  /*SizedBox(height: 10),
                  Row(
                    children: [
                      Text("Sets"),
                      SizedBox(width: 50),
                      SizedBox(
                        width: 180,
                        child: DropdownMenu(
                          textStyle: TextStyle(fontSize: 20),
                          controller: setSearchController,
                          dropdownMenuEntries: snapshot.data!,
                          requestFocusOnTap: true,
                          enableFilter: true,
                          menuHeight: 200,
                          onSelected: (value) async {
                            setState(() {
                              selectedSet = value!;
                            });
                            onSearch();
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      Flexible(child: BaseButton(
                        label: "Clear",
                        onPressed: () {
                          setState(() {
                            selectedSet = null;
                            setSearchController.clear();
                          });
                        },
                      ),) 
                    ],
                  ),*/
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BaseButton(
                        label: "Search",
                        onPressed: () async {
                          onSearch();
                        },
                      ),
                      SizedBox(width: 10),
                      BaseButton(
                        label: "Add search options",
                        onPressed: () async {
                            // show a dialog to add some option to the search
                            optionText = await showDialog(
                              context: context,
                              builder: (context) {
                                return ScryfallOptionDialog(optionsText: optionText);
                              },
                            );
                            onSearch();
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 10),
                  listOfCards.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Expanded(
                          child: GridView(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                            children: List.generate(listOfCards.value!.length, (
                              index,
                            ) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  // Correction du type pour correspondre à Color?
                                  color:
                                      widget.pickCards
                                          .where(
                                            (element) =>
                                                element.id ==
                                                listOfCards.value![index].id,
                                          )
                                          .isNotEmpty
                                      ? Colors.grey
                                      : Colors.white,
                                  child: InkWell(
                                    onTap: () {
                                      if (!widget.pickCards.contains(
                                        listOfCards.value![index],
                                      )) {
                                        setState(() {
                                          widget.pickCards.add(
                                            listOfCards.value![index],
                                          );
                                        });
                                      } else {
                                        setState(() {
                                          widget.pickCards.remove(
                                            listOfCards.value![index],
                                          );
                                        });
                                      }
                                    },
                                    onLongPress: () async {
                                      await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return CardDetailsWidget(
                                            card: listOfCards.value![index],
                                          );
                                        },
                                      );
                                    },
                                    child: Center(
                                      child:
                                          listOfCards.value![index].imageUris !=
                                              null
                                          ? Image(
                                              image: Image.network(
                                                listOfCards
                                                    .value![index]
                                                    .imageUris!
                                                    .normal
                                                    .toString(),
                                              ).image,
                                            )
                                          : listOfCards
                                                    .value![index]
                                                    .cardFaces !=
                                                null
                                          ? Image(
                                              image: Image.network(
                                                listOfCards
                                                    .value![index]
                                                    .cardFaces![0]
                                                    .imageUris!
                                                    .normal
                                                    .toString(),
                                              ).image,
                                            )
                                          : null,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: BaseButton(
        label: "Validate ${widget.pickCards.length} Selected Cards",
        onPressed: () {
          if (widget.pickCards.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Select at least one card"),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 1),
              ),
            );
          } else {
            Navigator.pop(context, widget.pickCards);
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
