/// will interact directly with the scryfall API to return search information

// final request will be a searchCards with a frankenstein query to get all the cards from a specific set and other information

import 'package:scryfall_api/scryfall_api.dart';
import 'package:deck_share/scryfall_searcher/domain/scryfall_repository.dart';


class ScryfallServices {
  final ScryfallRepository scryfallRepository;

  ScryfallServices({required this.scryfallRepository});

  // will get access to all the settings of the user to search cards by sets, CCM and other stuff
  Future<List<MtgCard>> searchCards(
    String? cardName,
    String? setCode,
    String? oracleText,
  ) async {
    return await scryfallRepository.searchCards(cardName, setCode, oracleText);
  }

  Future<List<MtgSet>> getAllSets() async {
    return await scryfallRepository.getAllSets();
  }

  Future<List<MtgCard>> getCardsOfSelectedSets(MtgSet mtgset) async {
    return await scryfallRepository.getCardsOfSelectedSets(mtgset);
  }

  Future<List<MtgCard>> getCardsWithName(String nameCards) async {
    return await scryfallRepository.getCardsWithName(nameCards);
  }

  Future<List<Ruling>> getRulingById(String id) async {
    return await scryfallRepository.getRulingById(id);
  }
}
