import 'package:deck_share/share_cards/application/share_cards_services.dart';
import 'package:deck_share/share_cards/data/providers/share_cards_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final shareCardsServiceProvider = Provider<ShareCardsServices>((ref) {
  return ShareCardsServices(
    localRepository: ref.read(shareCardsRepositoryProvider),
  );
});