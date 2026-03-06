

import 'package:deck_share/share_cards/application/providers/share_cards_providers.dart';
import 'package:deck_share/share_cards/domain/share_cards_model.dart';
import 'package:deck_share/share_cards/presentation/controller/share_cards_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scryfall_api/scryfall_api.dart';

final selectedItemProvider = StateProvider((ref) => "");
final indexProvider = StateProvider<int>((ref) => 0);
final pickcards = StateProvider<List<MtgCard>>(
  (ref) => List<MtgCard>.empty(growable: true),
);

final selectLoan = StateProvider<ShareCards>(
  (ref) => ShareCards(lenderId: "", applicantId: "", lendingCards: []),
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

final lentNumber = StateProvider<int>((ref) => 0);
final borrowNumber = StateProvider<int>((ref) => 0);

final lentNumberProvider = FutureProvider((ref) => ref.read(shareCardsControllerProvider.notifier).getNumberOfLentCard());
final borrowNumberProvider = FutureProvider((ref) => ref.read(shareCardsControllerProvider.notifier).getNumberOfBorrowCard());