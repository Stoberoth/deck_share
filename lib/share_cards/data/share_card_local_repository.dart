import 'dart:convert';
import 'dart:io';

import 'package:deck_share/core/data/base_local_repository.dart';
import 'package:deck_share/share_cards/data/share_card_repository.dart';
import 'package:deck_share/share_cards/domain/share_cards_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

final shareCardsLocalRepositoryProvider = Provider<ShareCardLocalRepository>((
  ref,
) {
  return ShareCardLocalRepository();
});

class ShareCardLocalRepository extends BaseLocalRepository<ShareCards>
    implements ShareCardRepository {
  @override
  Future<void> deleteShareCards(String id) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/share_cards.json");

    if (!file.existsSync()) {
      file.create();
    }
    final json = await file.readAsString();
    final content = jsonDecode(json);

    content["shareCards"].removeWhere((element) => element["id"] == id);
    file.writeAsString(jsonEncode(content), mode: FileMode.writeOnly);
  }

  @override
  Future<List<ShareCards>> getAllShareCards() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/share_cards.json");
    if (!file.existsSync()) {
      file.create();
    }
    final json = await file.readAsString();
    final content = json != '' ? jsonDecode(json)["shareCards"] : null;
    if (content == null) {
      return [];
    }
    return List<ShareCards>.from(
      content.map((shareCard) => ShareCards.fromJson(shareCard)),
    );
  }

  @override
  Future<ShareCards> getShareCardsById(String id) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/share_cards.json");
    final json = await file.readAsString();
    final content = jsonDecode(json)["shareCards"];
    return ShareCards.fromJson(
      content.where((element) => element["id"] == id).first,
    );
  }

  @override
  Future<void> saveShareCards(ShareCards shareCards) async {
    if (shareCards.id!.isEmpty) {
      shareCards.id = UniqueKey().toString();
    }
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/share_cards.json");
    if (!file.existsSync()) {
      file.create();
    }
    String json = await file.readAsString();
    if (json == "") {
      json = jsonEncode({"shareCards": []});
    }
    final content = jsonDecode(json);
    if (content["shareCards"]
        .where((element) => element["id"] == shareCards.id)
        .isNotEmpty) {
      for (int i = 0; i < content["shareCards"].length; ++i) {
        if (content["shareCards"][i]["id"] == shareCards.id) {
          content["shareCards"][i] = shareCards.toJson();
        }
      }
    } else {
      content["shareCards"].add(shareCards.toJson());
    }
    file.writeAsString(jsonEncode(content), mode: FileMode.writeOnly);
  }

  @override
  ShareCards fromJson(Map<String, dynamic> json) {
    return ShareCards.fromJson(json);
  }

  @override
  String getCollectionName() {
    // TODO: implement getCollectionName
    return "shareCards";
  }

  @override
  String getFileName() {
    return "share_cards.json";
  }

  @override
  String? getId(ShareCards item) {
    return item.id;
  }

  @override
  void setId(ShareCards item, String id) {
    item.id = id;
  }

  @override
  Map<String, dynamic> toJson(ShareCards item) {
    return item.toJson();
  }

  /*@override
  Future<void> updateShareCards(ShareCards shareCards) {
    // TODO: implement updateShareCards
    throw UnimplementedError();
  }*/
}
