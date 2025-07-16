import 'package:deck_share/share_cards/data/share_card_local_repository.dart';
import 'package:deck_share/share_cards/domain/share_cards_model.dart';

class ShareCardsServices {
  final ShareCardLocalRepository localRepository;

  ShareCardsServices({required this.localRepository});

  Future<void> saveShareCards(ShareCards shareCards) async {
    await localRepository.saveShareCards(shareCards);
  }

  Future<void> deleteShareCards(String id) async {
    await localRepository.deleteShareCards(id);
  }

  Future<void> getAllShareCards() async {
    await localRepository.getAllShareCards();
  }

  Future<void> getShareCardsById(String id) async {
    await localRepository.getShareCardsById(id);
  }

  Future<void> updateShareCards(ShareCards shareCards) async {
    await localRepository.updateShareCards(shareCards);
  }
}
