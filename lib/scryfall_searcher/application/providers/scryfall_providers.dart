import 'package:deck_share/scryfall_searcher/application/scryfall_services.dart';
import 'package:deck_share/scryfall_searcher/data/providers/scryfall_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scryfallServiceProvider = Provider((ref) {
  return ScryfallServices(scryfallRepository: ref.read(scryfallRepositoryProvider));
});