import 'package:deck_share/share_cards/application/share_cards_services.dart';
import 'package:deck_share/share_cards/data/providers/share_cards_providers.dart';
import 'package:deck_share/user/application/providers/user_providers.dart';
import 'package:deck_share/user/domain/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentUserProfileProvider = FutureProvider<UserProfile>((ref) async {
  return await ref.watch(userServicesProvider).getUserInformation();
});

final shareCardsServiceProvider = Provider<ShareCardsServices>((ref) {
  return ShareCardsServices(
    repository: ref.watch(shareCardsRepositoryProvider),
    userServices: ref.watch(userServicesProvider)
  );
});