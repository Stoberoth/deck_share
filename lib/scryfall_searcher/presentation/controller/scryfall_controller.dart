import 'dart:collection';

import 'package:deck_share/scryfall_searcher/application/scryfall_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scryfall_api/scryfall_api.dart';

/// widget that will communicate with the service to send the information to the pages and show them

typedef MtgSetEntry = DropdownMenuEntry<MtgSet>;

final scryfallControllerProvider =
    StateNotifierProvider<ScryfallController, AsyncValue<List<MtgCard>>>((ref) {
      return ScryfallController(
        scryfallServices: ref.read(scryfallServiceProvider),
      );
    });

class ScryfallController extends StateNotifier<AsyncValue<List<MtgCard>>> {
  final ScryfallServices scryfallServices;

  ScryfallController({required this.scryfallServices})
    : super(AsyncValue.data([]));

  Future<List<MtgSetEntry>> getAllSets() async {
    final list = await scryfallServices.getAllSets();
    if(list.isEmpty) return [];
    final List<MtgSetEntry> entries = UnmodifiableListView<MtgSetEntry>(
      list.map(
        (MtgSet mtgSet) => MtgSetEntry(value: mtgSet, label: mtgSet.name),
      ),
    );
    return entries;
  }

  Future<void> getCardsOfSelectedSets(MtgSet setName) async
  {
    state = AsyncValue.loading();
    List<MtgCard> list = await scryfallServices.getCardsOfSelectedSets(setName);
    state = AsyncValue.data(list.isNotEmpty ? list : []);
  }

  Future<void> getCardsWithName(String name) async
  {
    state = AsyncValue.loading();
    List<MtgCard> list = await scryfallServices.getCardsWithName(name);
    print(list.length);
    state = AsyncValue.data(list.isNotEmpty ? list : []);
  }
}
