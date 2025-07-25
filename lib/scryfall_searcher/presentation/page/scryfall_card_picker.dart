import 'dart:collection';

import 'package:deck_share/scryfall_searcher/presentation/controller/scryfall_controller.dart';
import 'package:deck_share/scryfall_searcher/presentation/widget/card_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scryfall_api/scryfall_api.dart';

/// A page the will show all the cards we want to search and permit to pick them to add them to a wishlist or a share list

class ScryfallCardPicker extends ConsumerStatefulWidget {
  const ScryfallCardPicker({super.key});

  @override
  ConsumerState<ScryfallCardPicker> createState() => _ScryfallCardPickerState();
}

class _ScryfallCardPickerState extends ConsumerState<ScryfallCardPicker> {
  MtgSet? selected_set;
  List<MtgCard> pickCards = [];
  TextEditingController searchController = TextEditingController();
  TextEditingController searchOracleController = TextEditingController();
  TextEditingController setSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AsyncValue state = ref.read(scryfallControllerProvider);

    List<MtgCard> listOfCards = state.value ?? [];
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
                      await ref
                          .read(scryfallControllerProvider.notifier)
                          .searchCards(
                            cardName: searchController.text,
                            setCode: selected_set?.code,
                            oracleText: searchOracleController.text,
                          );
                      setState(() {
                        
                      });
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
                      await ref
                          .read(scryfallControllerProvider.notifier)
                          .searchCards(
                            cardName: searchController.text,
                            setCode: selected_set?.code,
                            oracleText: searchOracleController.text,
                          );
                      setState(() {
                        
                      });
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
                              await ref
                                  .read(scryfallControllerProvider.notifier)
                                  .searchCards(
                                    cardName: searchController.text,
                                    setCode: selected_set?.code,
                                    oracleText: searchOracleController.text,
                                  );
                              setState(() {});
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
                      await ref
                          .read(scryfallControllerProvider.notifier)
                          .searchCards(
                            cardName: searchController.text,
                            setCode: selected_set?.code,
                            oracleText: searchOracleController.text,
                          );
                      setState(() {});
                    },
                    child: Text("Search"),
                  ),
                  SizedBox(height: 10),
                  state.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Expanded(
                          child: GridView(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                            children: List.generate(listOfCards.length, (
                              index,
                            ) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  // Correction du type pour correspondre à Color?
                                  color:
                                      pickCards
                                          .where(
                                            (element) =>
                                                element.id ==
                                                listOfCards[index].id,
                                          )
                                          .isNotEmpty
                                      ? Colors.amber
                                      : Colors.white,
                                  child: InkWell(
                                    onTap: () {
                                      if (!pickCards.contains(
                                        listOfCards[index],
                                      )) {
                                        setState(() {
                                          pickCards.add(listOfCards[index]);
                                        });
                                      } else {
                                        setState(() {
                                          pickCards.remove(listOfCards[index]);
                                        });
                                      }
                                    },
                                    onLongPress: () async {
                                      await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return CardDetails_widget(
                                            card: listOfCards[index],
                                          );
                                        },
                                      );
                                    },
                                    child: Center(
                                      child:
                                          listOfCards[index].imageUris != null
                                          ? Image(
                                              image: Image.network(
                                                listOfCards[index]
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
          if (pickCards.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Select at least one card"),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 1),
              ),
            );
          } else {
            Navigator.pop(context, pickCards);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
