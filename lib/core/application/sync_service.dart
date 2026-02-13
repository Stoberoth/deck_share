import 'package:deck_share/share_cards/domain/share_card_repository.dart';

class SyncService {
  final ShareCardRepository localRepo;
  final ShareCardRepository firebaseRepo;

  SyncService({required this.localRepo, required this.firebaseRepo});
  
  Future<void> syncShareCards() async {
    try {
      final firebaseCards = await firebaseRepo.getAllShareCards();

      for (final card in firebaseCards) {
        await localRepo.saveShareCards(card);
      }
      print("Synchronisation effectuée");
    } catch (e) {
      print("Erreur de synchronisation");
    }
  }
}
