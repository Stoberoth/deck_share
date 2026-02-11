import 'package:deck_share/scryfall_searcher/application/providers/scryfall_providers.dart';
import 'package:deck_share/scryfall_searcher/presentation/controller/scryfall_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scryfall_api/scryfall_api.dart';

final scryfallControllerProvider =
    StateNotifierProvider<ScryfallController, AsyncValue<List<MtgCard>>>((ref) {
      return ScryfallController(
        scryfallServices: ref.read(scryfallServiceProvider),
      );
    });
