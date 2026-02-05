import 'package:deck_share/share_cards/application/share_cards_services.dart';
import 'package:deck_share/share_cards/domain/share_cards_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedItemProvider = StateProvider((ref) => "");

final shareCardsControllerProvider =
    StateNotifierProvider<ShareCardsController, AsyncValue<List<ShareCards>>>((
      ref,
    ) {
      return ShareCardsController(
        shareCardsServices: ref.read(shareCardsServiceProvider),
        selectedItem: ref.read(selectedItemProvider),
      );
    });

class ShareCardsController extends StateNotifier<AsyncValue<List<ShareCards>>> {
  final ShareCardsServices shareCardsServices;
  String selectedItem;

  ShareCardsController({
    required this.shareCardsServices,
    required this.selectedItem,
  }) : super(const AsyncValue.data([])) {
    getAllShareCards();
  }

  Future<void> addShareCards(ShareCards shareCards) async {
    state = const AsyncLoading();
    await shareCardsServices.saveShareCards(shareCards);
    getAllShareCards();
  }

  Future<void> selectItem(String id) async {
    selectedItem = id;
  }

  Future<void> deleteShareCards(String id) async {
    state = const AsyncLoading();
    await shareCardsServices.deleteShareCards(id);
    getAllShareCards();
  }

  Future<void> markAsReturned(String id) async {
    await shareCardsServices.markAsReturned(id);
    await shareCardsServices.getAllShareCards();
  }

  Future<void> extendLoan(String id, DateTime newReturnDate) async {
    await shareCardsServices.extendLoan(id, newReturnDate);
    await shareCardsServices.getAllShareCards();
  }

  Future<void> getAllShareCards() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return shareCardsServices.getAllShareCards();
    });
  }

  Future<void> getByStatus(ShareCardsStatus status) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      return shareCardsServices.getByStatus(status);
    });
  }

  Future<int> getNumberOfLent() async
  {
    return shareCardsServices.getNumberOfLent();
  }

  Future<int> getNumberOfBorrow() async
  {
    return shareCardsServices.getNumberOfBorrow();
  }

  Future<void> getLentCards() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return shareCardsServices.getLentCards();
    });
  }

  Future<void> getBorrowedCards() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return shareCardsServices.getBorrowedCards();
    });
  }

  Future<ShareCards> getShareCardsbyId(String id) async {
    return await shareCardsServices.getShareCardsById(id);
  }
}
