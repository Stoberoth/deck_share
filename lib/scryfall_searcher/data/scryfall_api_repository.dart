import 'dart:convert';

import 'package:deck_share/scryfall_searcher/domain/scryfall_repository.dart';
import 'package:scryfall_api/scryfall_api.dart';
import 'package:http/http.dart' as http;

class ScryfallApiRepository implements ScryfallRepository {
  final _baseUrl = 'api.scryfall.com';
  final _headers = {"User-Agent": "deck_share 1.0", "Accept": "*/*"};

  ScryfallApiRepository();

  Future<PaginableList<T>> _loadNextPage<T>({
    required Uri nextPageUri,
    required T Function(Object?) fromJson,
  }) async {
    final response = await http.get(nextPageUri, headers: _headers);

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
    final url = Uri.https(_baseUrl, '/sets');
    final response = await http.get(url, headers: _headers);

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw ScryfallException.fromJson(json);
    }

    final page = PaginableList<MtgSet>.fromJson(
      json,
      (set) => MtgSet.fromJson(set as Map<String, dynamic>),
    );
    listAllSets = await _loadAllPages(
      paginableList: page,
      fromJson: (json) => MtgSet.fromJson(json as Map<String, dynamic>),
    );
    return listAllSets;

    //return listAllSets;
  }

  @override
  Future<List<MtgCard>> getCardsOfSelectedSets(MtgSet mtgset) async {
    try {
      PaginableList<MtgCard> paginableList = await _search("e:${mtgset.code}");
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
      final paginableList = await _search("$name");
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
    try {
      final url = Uri.https(_baseUrl, '/cards/$id/rulings');
      final response = await http.get(url);

      final json = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        throw ScryfallException.fromJson(json);
      }

      final paginableList = PaginableList.fromJson(
        json,
        (ruling) => Ruling.fromJson(ruling as Map<String, dynamic>),
      );

      final list = await _loadAllPages<Ruling>(
        paginableList: paginableList,
        fromJson: (json) => Ruling.fromJson(json as Map<String, dynamic>),
      );
      return list;
    } on ScryfallException catch (e) {
      throw Exception("Erreur Scryfall ${e.details}");
    }
  }

  Future<PaginableList<MtgCard>> _search(String query) async {
    final url = Uri.https(
      _baseUrl,
      '/cards/search',
      <String, String?>{
        'q': query,
        'unique': "",
        'order': "",
        'dir': "",
        'include_extras': "",
        'include_multilingual': "",
        'include_variations': "",
        'page': "",
      }..removeWhere((_, value) => value == null),
    );
    final response = await http.get(
      url,
      headers: _headers,
    );

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw ScryfallException.fromJson(json);
    }

    return PaginableList<MtgCard>.fromJson(
      json,
      (card) => MtgCard.fromJson(card as Map<String, dynamic>),
    );
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

    _search(searchQuery);
    List<MtgCard> list = List.empty();
    try {
      PaginableList<MtgCard> paginableList = await _search(searchQuery);
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
