import 'dart:collection';

import 'package:deck_share/scryfall_searcher/presentation/controller/scryfall_controller.dart';
import 'package:deck_share/scryfall_searcher/presentation/widget/card_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scryfall_api/scryfall_api.dart';

/// A page the will show all the cards we want to search and permit to pick them to add them to a wishlist or a share list

class ScryfallCardPicker extends ConsumerStatefulWidget {
  List<MtgCard> pickCards = [];
  ScryfallCardPicker({super.key, required this.pickCards});

  @override
  ConsumerState<ScryfallCardPicker> createState() => _ScryfallCardPickerState();
}

class _ScryfallCardPickerState extends ConsumerState<ScryfallCardPicker> {
  MtgSet? selected_set;

  TextEditingController searchController = TextEditingController();
  TextEditingController searchOracleController = TextEditingController();
  TextEditingController setSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<MtgCard>> listOfCards = ref.watch(
      scryfallControllerProvider,
    );

    return Scaffold(
      appBar: AppBar(title: Text("Scryfall card picker")),
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
                  TextField(
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Search card by name",
                      icon: Icon(Icons.search),
                    ),
                    onSubmitted: (value) async {
                      try {
                        await ref
                            .read(scryfallControllerProvider.notifier)
                            .searchCards(
                              cardName: searchController.text,
                              setCode: selected_set?.code,
                              oracleText: searchOracleController.text,
                            );
                      } on ScryfallException catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Erreur Scryfall : ${e.details}"),
                          ),
                        );
                      }
                      //setState(() {});
                    },
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: searchOracleController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Search card by oracle text",
                      icon: Icon(Icons.search),
                    ),
                    onSubmitted: (value) async {
                      try {
                        await ref
                            .read(scryfallControllerProvider.notifier)
                            .searchCards(
                              cardName: searchController.text,
                              setCode: selected_set?.code,
                              oracleText: searchOracleController.text,
                            );
                      } on ScryfallException catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Erreur Scryfall : ${e.details}"),
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text("Sets"),
                      SizedBox(width: 50),
                      SizedBox(
                        width: 200,
                        child: DropdownMenu(
                          textStyle: TextStyle(fontSize: 20),
                          controller: setSearchController,
                          dropdownMenuEntries: snapshot.data!,
                          requestFocusOnTap: true,
                          enableFilter: true,
                          menuHeight: 200,
                          onSelected: (value) async {
                            setState(() {
                              selected_set = value!;
                            });
                            try {
                              await ref
                                  .read(scryfallControllerProvider.notifier)
                                  .searchCards(
                                    cardName: searchController.text,
                                    setCode: selected_set?.code,
                                    oracleText: searchOracleController.text,
                                  );
                            } on ScryfallException catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Erreur Scryfall : ${e.details}",
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selected_set = null;
                            setSearchController.clear();
                          });
                        },
                        child: Text("Clear"),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await ref
                            .read(scryfallControllerProvider.notifier)
                            .searchCards(
                              cardName: searchController.text,
                              setCode: selected_set?.code,
                              oracleText: searchOracleController.text,
                            );
                      } on ScryfallException catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Erreur Scryfall : ${e.details}"),
                          ),
                        );
                      }
                      //setState(() {});
                    },
                    child: Text("Search"),
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
                                      ? Colors.amber
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
                                          return CardDetails_widget(
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
      floatingActionButton: FloatingActionButton(
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
        child: Icon(Icons.add),
      ),
    );
  }
}
