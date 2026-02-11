import 'package:deck_share/share_cards/data/share_card_local_repository.dart';
import 'package:deck_share/share_cards/domain/share_card_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final shareCardsRepositoryProvider = Provider<ShareCardRepository>((
  ref,
) {
  return ShareCardLocalRepository();
});