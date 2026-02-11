import 'dart:convert';

import 'package:deck_share/scryfall_searcher/domain/scryfall_repository.dart';
import 'package:scryfall_api/scryfall_api.dart';
import 'package:http/http.dart' as http;

class ScryfallApiRepository implements ScryfallRepository {
  final ScryfallApiClient scryfallApiClient;

  ScryfallApiRepository({required this.scryfallApiClient});

  Future<PaginableList<T>> _loadNextPage<T>({
    required Uri nextPageUri,
    required T Function(Object?) fromJson,
  }) async {
    final response = await http.get(nextPageUri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return PaginableList.fromJson(json, fromJson);
    } else {
      throw Exception('Failed to load next page: ${response.statusCode}');
    }
  }

  Future<List<T>> _loadAllPages<T>({
    required PaginableList<T> paginableList,
    required T Function(Object?) fromJson,
  }) async {
    List<T> allData = [];
    allData.addAll(paginableList.data);

    PaginableList<T> currentPage = paginableList;
    while (currentPage.hasMore && paginableList.nextPage != null) {
      currentPage = await _loadNextPage<T>(
        nextPageUri: currentPage.nextPage!,
        fromJson: fromJson,
      );
      allData.addAll(currentPage.data);
    }
    return allData;
  }

  @override
  Future<List<MtgSet>> getAllSets() async {
    List<MtgSet> listAllSets = List.empty();
    PaginableList<MtgSet> paginableAllSets = await scryfallApiClient
        .getAllSets();
    listAllSets = await _loadAllPages(
      paginableList: paginableAllSets,
      fromJson: (json) => MtgSet.fromJson(json as Map<String, dynamic>),
    );
    return listAllSets;
  }

  @override
  Future<List<MtgCard>> getCardsOfSelectedSets(MtgSet mtgset) async {
    try {
      PaginableList<MtgCard> paginableList = await scryfallApiClient
          .searchCards("e:${mtgset.code}");
      final list = await _loadAllPages(
        paginableList: paginableList,
        fromJson: (json) => MtgCard.fromJson(json as Map<String, dynamic>),
      );
      return list;
    } on ScryfallException catch (e) {
      throw Exception("Erreur Scryfall ${e.details}");
    }
  }

  @override
  Future<List<MtgCard>> getCardsWithName(String name) async {
    try {
      final paginableList = await scryfallApiClient.searchCards(name);
      final list = await _loadAllPages(
        paginableList: paginableList,
        fromJson: (json) => MtgCard.fromJson(json as Map<String, dynamic>),
      );
      return list;
    } on ScryfallException catch (e) {
      throw Exception("Erreur Scryfall ${e.details}");
    }
  }

  @override
  Future<List<Ruling>> getRulingById(String id) async {
    try{
      final paginableList = await scryfallApiClient.getRulingsById(id);
      final list = await _loadAllPages<Ruling>(paginableList: paginableList, fromJson: (json) => Ruling.fromJson(json as Map<String, dynamic>));
      return list;
    }
    on ScryfallException catch (e)
    {
      throw Exception("Erreur Scryfall ${e.details}");
    }
  }

  @override
  Future<List<MtgCard>> searchCards(
    String? cardName,
    String? setCode,
    String? oracleText,
  ) async {
    String searchQuery = "";
    searchQuery += cardName != null && cardName.isNotEmpty ? cardName : "";
    searchQuery += setCode != null && setCode.isNotEmpty ? " e:$setCode" : "";
    searchQuery += oracleText != null && oracleText.isNotEmpty
        ? " o:$oracleText"
        : "";

    searchQuery = "$searchQuery game:paper not:digital";
    List<MtgCard> list = List.empty();
    try {
      PaginableList<MtgCard> paginableList = await scryfallApiClient
          .searchCards(searchQuery);
      list = await _loadAllPages(
        paginableList: paginableList,
        fromJson: (json) => MtgCard.fromJson(json as Map<String, dynamic>),
      );
      return list;
    } on ScryfallException {
      rethrow;
    }
  }
}
