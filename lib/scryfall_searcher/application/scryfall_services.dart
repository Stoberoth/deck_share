///
/// will interact directly with the scryfall API to return search information

// final request will be a searchCards with a frankenstein query to get all the cards from a specific set and other information

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scryfall_api/scryfall_api.dart';

final scryfallServiceProvider = Provider((ref) {
  return ScryfallServices(scryfallApiClient: ScryfallApiClient());
});

class ScryfallServices {
  final ScryfallApiClient scryfallApiClient;

  ScryfallServices({required this.scryfallApiClient});

  // will get access to all the settings of the user to search cards by sets, CCM and other stuff
  Future<void> searchCards() async {
    final set = await scryfallApiClient.getSetById("afr");
  }

  Future<List<MtgSet>> getAllSets() async {
    PaginableList<MtgSet> allSets = await scryfallApiClient.getAllSets();
    return allSets.data;
  }

   Future<List<MtgCard>> getCardsOfSelectedSets(MtgSet mtgset) async
   {
      final list = await scryfallApiClient.searchCards("e:${mtgset.code}");
      return list.data.isNotEmpty ? list.data : [];
   }

   Future<List<MtgCard>> getCardsWithName(String nameCards) async
   {
      final list = await scryfallApiClient.searchCards(nameCards);
      return list.data.isNotEmpty ? list.data : [];
   }
}
