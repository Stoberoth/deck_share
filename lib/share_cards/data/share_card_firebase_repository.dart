import 'package:deck_share/core/data/base_firebase_repository.dart';
import 'package:deck_share/share_cards/domain/share_card_repository.dart';
import 'package:deck_share/share_cards/domain/share_cards_model.dart';


class ShareCardFirebaseRepository extends BaseFirebaseRepository<ShareCards>
    implements ShareCardRepository {
  
  @override
  ShareCards fromJson(Map<String, dynamic> json) {
    return ShareCards.fromJson(json);
  }

  @override
  String getCollectionName() {
    return 'shareCards';
  }

  @override
  String? getId(ShareCards item) {
    return item.id;
  }

  @override
  ShareCards setId(ShareCards item, String id) {
    return item.copyWith(id: id);
  }

  @override
  Map<String, dynamic> toJson(ShareCards item) {
    return item.toJson();
  }

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
}
