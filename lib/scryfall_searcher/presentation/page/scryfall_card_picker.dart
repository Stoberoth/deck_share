import 'dart:collection';

import 'package:deck_share/scryfall_searcher/presentation/controller/scryfall_controller.dart';
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

  @override
  Widget build(BuildContext context) {
    final AsyncValue state = ref.read(scryfallControllerProvider);

    List<MtgCard> listOfCards = state.value ?? [];

    return Scaffold(
      appBar: AppBar(title: Text("Scryfall card picker")),
      body: SafeArea(
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
                    labelText: "Search name card",
                    icon: Icon(Icons.search),
                  ),
                  onSubmitted: (value) async {
                    await ref
                        .read(scryfallControllerProvider.notifier)
                        .getCardsWithName(value);
                    setState(() {});
                  },
                ),
                Row(
                  children: [
                    Text("Sets"),
                    SizedBox(width: 50),
                    SizedBox(
                      width: 300,
                      child: DropdownMenu(
                        dropdownMenuEntries: snapshot.data!,
                        requestFocusOnTap: true,
                        enableFilter: true,
                        menuHeight: 200,
                        onSelected: (value) async {
                          setState(() {
                            selected_set = value!;
                          });
                          if (selected_set != null) {
                            await ref
                                .read(scryfallControllerProvider.notifier)
                                .getCardsOfSelectedSets(selected_set!);
                          }
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                state.isLoading
                    ? const CircularProgressIndicator()
                    : Expanded(
                        child: GridView(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                          children: List.generate(listOfCards.length, (index) {
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

                                      print(pickCards.length);
                                    }
                                  },
                                  child: Center(
                                    child: listOfCards[index].imageUris != null
                                        ? Image(
                                            image: Image.network(
                                              listOfCards[index]
                                                  .imageUris!
                                                  .normal
                                                  .toString(),
                                            ).image,
                                          )
                                        : Placeholder(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, pickCards);
        },
        
      ),
    );
  }
}
