import 'package:deck_share/share_cards/domain/share_cards_model.dart';

abstract class ShareCardRepository {
  Future<void> saveShareCards(ShareCards shareCards);
  Future<ShareCards> getShareCardsById(String id);
  Future<void> deleteShareCards(String id);
  //Future<void> updateShareCards(ShareCards shareCards);
  Future<List<ShareCards>> getAllShareCards();
}