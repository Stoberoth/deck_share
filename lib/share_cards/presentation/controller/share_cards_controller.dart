import 'package:deck_share/share_cards/application/share_cards_services.dart';
import 'package:deck_share/share_cards/domain/share_cards_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ShareCardsController extends StateNotifier<AsyncValue<List<ShareCards>>> {
  final ShareCardsServices shareCardsServices;

  ShareCardsController({
    required this.shareCardsServices,
  }) : super(const AsyncValue.data([]));

  Future<void> addShareCards(ShareCards shareCards) async {
    state = const AsyncLoading();
    await shareCardsServices.saveShareCards(shareCards);
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



  Future<int> getNumberOfCurrentLent() async {
    return shareCardsServices.getNumberOfCurrentLent();
  }

  Future<int> getNumberOfCurrentBorrow() async {
    return shareCardsServices.getNumberOfCurrentBorrow();
  }

  Future<int> getNumberOfLentCard() async{
    return shareCardsServices.getNumberOfLent();
  }
  
  Future<int> getNumberOfBorrowCard() async{
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
