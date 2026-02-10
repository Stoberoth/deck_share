// interface de scryfall_repository
import 'package:scryfall_api/scryfall_api.dart';

abstract class ScryfallRepository {
  // Méthode de discution avec la base de données
  Future<List<MtgCard>> searchCards(String? cardName, String? setCode, String? oracleText);
  Future<List<MtgSet>> getAllSets();
  Future<List<MtgCard>> getCardsOfSelectedSets(MtgSet mtgset);
  Future<List<MtgCard>> getCardsWithName(String name);
  Future<List<Ruling>> getRulingById(String id);
}