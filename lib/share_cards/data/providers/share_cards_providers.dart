import 'package:deck_share/core/application/providers/connectivity_provider.dart';
import 'package:deck_share/share_cards/data/share_card_firebase_repository.dart';
import 'package:deck_share/share_cards/data/share_card_local_repository.dart';
import 'package:deck_share/share_cards/domain/share_card_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final shareCardLocalRepositoryProvider = Provider<ShareCardRepository>((ref) => ShareCardLocalRepository(),);

final shareCardFirebaseRepositoryProvider = Provider<ShareCardRepository>((ref) => ShareCardFirebaseRepository(),);

final shareCardsRepositoryProvider = Provider<ShareCardRepository>((ref) {
  final connectivityAsync = ref.watch(isConnectedProvider);

  // Si connecté on prend le repo firebase sinon on se focus sur le local
  return connectivityAsync.when(
    data: (isConnected) {
      if (isConnected) {
        return ref.read(shareCardFirebaseRepositoryProvider);
      } else {
        return ref.read(shareCardLocalRepositoryProvider);
      }
    },
    error: (_, _) => ref.read(shareCardLocalRepositoryProvider),
    loading: () => ref.read(shareCardFirebaseRepositoryProvider),
  );
});
