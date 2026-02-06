import 'package:deck_share/share_cards/application/share_cards_services.dart';
import 'package:deck_share/share_cards/domain/share_cards_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scryfall_api/scryfall_api.dart';

final selectedItemProvider = StateProvider((ref) => "");
final indexProvider = StateProvider<int>((ref) => 0);
final pickcards = StateProvider<List<MtgCard>>(
  (ref) => List<MtgCard>.empty(growable: true),
);

final selectLoan = StateProvider<ShareCards>(
  (ref) => ShareCards(lender: "", applicant: "", lendingCards: []),
);

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
  }) : super(const AsyncValue.data([]));

  Future<void> addShareCards(ShareCards shareCards) async {
    state = const AsyncLoading();
    await shareCardsServices.saveShareCards(shareCards);
  }

  Future<void> selectItem(String id) async {
    selectedItem = id;
  }

  Future<void> deleteShareCards(String id) async {
    state = const AsyncLoading();
    await shareCardsServices.deleteShareCards(id);
  }

  Future<void> markAsReturned(String id, int filter) async {
    state = const AsyncLoading();
    await shareCardsServices.markAsReturned(id);
    if (filter == 0) {
      state = await AsyncValue.guard(() async {
        final result = await shareCardsServices.getLentCards();
        return result;
      });
    }
    else
    {
      state = await AsyncValue.guard(() async {
        final result = await shareCardsServices.getBorrowedCards();
        return result;
      });
    }
  }

  Future<void> extendLoan(String id, DateTime newReturnDate, int filter) async {
    state = const AsyncLoading();
    await shareCardsServices.extendLoan(id, newReturnDate);
    if (filter == 0) {
      state = await AsyncValue.guard(() async {
        final result = await shareCardsServices.getLentCards();
        return result;
      });
    }
    else
    {
      state = await AsyncValue.guard(() async {
        final result = await shareCardsServices.getBorrowedCards();
        return result;
      });
    }
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

  Future<int> getNumberOfLent() async {
    return shareCardsServices.getNumberOfLent();
  }

  Future<int> getNumberOfBorrow() async {
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
