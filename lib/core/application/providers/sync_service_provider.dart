import 'package:deck_share/core/application/sync_service.dart';
import 'package:deck_share/share_cards/data/providers/share_cards_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final syncServiceProvider = Provider(
  (ref) => SyncService(
    localRepo: ref.read(shareCardLocalRepositoryProvider),
    firebaseRepo: ref.read(shareCardFirebaseRepositoryProvider),
  ),
);
