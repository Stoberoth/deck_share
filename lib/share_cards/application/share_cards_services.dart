import 'package:deck_share/share_cards/data/share_card_local_repository.dart';
import 'package:deck_share/share_cards/domain/share_cards_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final shareCardsServiceProvider = Provider<ShareCardsServices>((ref) {
  return ShareCardsServices(
    localRepository: ref.read(shareCardsLocalRepositoryProvider),
  );
});

class ShareCardsServices {
  final ShareCardLocalRepository localRepository;

  ShareCardsServices({required this.localRepository});

  Future<void> saveShareCards(ShareCards shareCards) async {
    await localRepository.saveShareCards(shareCards);
  }

  Future<void> deleteShareCards(String id) async {
    await localRepository.deleteShareCards(id);
  }

  Future<List<ShareCards>> getAllShareCards() async {
    return await localRepository.getAllShareCards();
  }

  Future<ShareCards> getShareCardsById(String id) async {
    return await localRepository.getShareCardsById(id);
  }

  Future<void> updateShareCards(ShareCards shareCards) async {
    await localRepository.updateShareCards(shareCards);
  }
}
