import 'package:deck_share/share_cards/application/share_cards_services.dart';
import 'package:deck_share/share_cards/domain/share_cards_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShareCardsController extends StateNotifier<AsyncValue<List<ShareCards>>> {
  final ShareCardsServices shareCardsServices;

  ShareCardsController({required this.shareCardsServices})
    : super(const AsyncValue.data([]));

  Future<void> addShareCards(ShareCards shareCards) async {
    state = const AsyncLoading();
    await shareCardsServices.saveShareCards(shareCards);
    getAllShareCards();
  }

  Future<void> deleteShareCards(String id) async {
    state = const AsyncLoading();
    await shareCardsServices.deleteShareCards(id);
    getAllShareCards();
  }

  Future<void> getAllShareCards() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return shareCardsServices.getAllShareCards();
    });
  }

  Future<ShareCards> getShareCardsbyId(String id) async {
    return await shareCardsServices.getShareCardsById(id);
  }
}
