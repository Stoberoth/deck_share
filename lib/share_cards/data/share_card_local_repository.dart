import 'package:deck_share/core/data/base_local_repository.dart';
import 'package:deck_share/share_cards/data/share_card_repository.dart';
import 'package:deck_share/share_cards/domain/share_cards_model.dart';



class ShareCardLocalRepository extends BaseLocalRepository<ShareCards>
    implements ShareCardRepository {
  @override
  Future<void> deleteShareCards(String id) async {
    await delete(id);
  }

  @override
  Future<List<ShareCards>> getAllShareCards() async {
    return await getAll(); 
  }

  @override
  Future<ShareCards> getShareCardsById(String id) async {
    return await getById(id);
  }

  @override
  Future<void> saveShareCards(ShareCards shareCards) async {
    await save(shareCards);
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
  Map<String, dynamic> toJson(ShareCards item) {
    return item.toJson();
  }
  
  @override
  ShareCards setId(ShareCards item, String id) {
    // TODO: implement setId
    return item.copyWith(id: id);
  }

  /*@override
  Future<void> updateShareCards(ShareCards shareCards) {
    // TODO: implement updateShareCards
    throw UnimplementedError();
  }*/
}
