import 'package:deck_share/share_cards/data/share_card_local_repository.dart';
import 'package:deck_share/share_cards/domain/share_cards_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final shareCardsServiceProvider = Provider<ShareCardsServices>((ref) {
  return ShareCardsServices(
    localRepository: ref.read(shareCardsLocalRepositoryProvider),
  );
});

class ShareCardsServices {
  final ShareCardLocalRepository localRepository;

  ShareCardsServices({required this.localRepository});

  // Marquer un prêt comme rendu
  Future<void> markAsReturned(String id) async {
    final shareCards = await getShareCardsById(id);
    ShareCards newShareCards = ShareCards(
      id: shareCards.id,
      title: shareCards.title,
      expectedReturnDate: shareCards.expectedReturnDate,
      returnedAt: DateTime.now(),
      status: ShareCardsStatus.returned,
      notes: shareCards.notes,
      lender: shareCards.lender,
      applicant: shareCards.applicant,
      lendingCards: shareCards.lendingCards,
      lendingDate: shareCards.lendingDate,
    );
    saveShareCards(newShareCards);
  }

  // Prolonger un prêt
  Future<void> extendLoan(String id, DateTime newReturnDate) async {
    final shareCards = await getShareCardsById(id);
    ShareCards newShareCards = ShareCards(
      id: shareCards.id,
      title: shareCards.title,
      expectedReturnDate: newReturnDate,
      returnedAt: shareCards.returnedAt,
      status: shareCards.status,
      notes: shareCards.notes,
      lender: shareCards.lender,
      applicant: shareCards.applicant,
      lendingCards: shareCards.lendingCards,
      lendingDate: shareCards.lendingDate,
    );
    saveShareCards(newShareCards);
  }

  // Filtre les prêts par status
  Future<List<ShareCards>> getByStatus(ShareCardsStatus status) async {
    final all = await getAllShareCards();
    return all.where((sc) => sc.status == status).toList();
  }

  Future<int> getNumberOfLent() async
  {
    final all = await getAllShareCards();
    return all.where((sc) => sc.lender == "Me" && sc.returnedAt == null).toList().length;
  }

   Future<int> getNumberOfBorrow() async
  {
    final all = await getAllShareCards();
    return all.where((sc) => sc.applicant == "Me" && sc.returnedAt == null).toList().length;
  }

  // Obtenir les prêts que je fais (lender = "Me")
  Future<List<ShareCards>> getLentCards() async {
    final all = await getAllShareCards();
    return all.where((sc) => sc.lender == "Me").toList();
  }

  //Obtenir les prêts que je reçois
  Future<List<ShareCards>> getBorrowedCards() async {
    final all = await getAllShareCards();
    return all.where((sc) => sc.applicant == "Me").toList();
  }

  Future<void> saveShareCards(ShareCards shareCards) async {
    await localRepository.saveShareCards(shareCards);
  }

  Future<void> deleteShareCards(String id) async {
    await localRepository.deleteShareCards(id);
  }

  Future<List<ShareCards>> getAllShareCards() async {
    return await localRepository.getAllShareCards();
  }

  Future<ShareCards> getShareCardsById(String id) async {
    return await localRepository.getShareCardsById(id);
  }

  Future<void> updateShareCards(ShareCards shareCards) async {
    await localRepository.updateShareCards(shareCards);
  }
}
