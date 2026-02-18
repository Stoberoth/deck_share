// Manage all the providers of the data layer

import 'package:deck_share/scryfall_searcher/data/scryfall_api_repository.dart';
import 'package:deck_share/scryfall_searcher/domain/scryfall_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scryfallRepositoryProvider = Provider<ScryfallRepository>((ref) {
  return ScryfallApiRepository();
});
