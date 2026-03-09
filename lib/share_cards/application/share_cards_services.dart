import 'package:deck_share/share_cards/domain/share_card_repository.dart';
import 'package:deck_share/share_cards/domain/share_cards_model.dart';
import 'package:deck_share/user/application/user_services.dart';

class ShareCardsServices {
  final ShareCardRepository repository;
  final UserServices userServices;
  String? _cachedUserId;

  ShareCardsServices({required this.repository, required this.userServices});

  Future<String> _getUserId() async{
    _cachedUserId ??= (await userServices.getUserInformation()).id;
    return _cachedUserId ?? "";
  }
  // Marquer un prêt comme rendu
  Future<void> markAsReturned(String id) async {
    final shareCards = await getShareCardsById(id);
    await saveShareCards(shareCards.copyWith(returnedAt: DateTime.now(), status: ShareCardsStatus.returned));
  }

  // Prolonger un prêt
  Future<void> extendLoan(String id, DateTime newReturnDate) async {
    final shareCards = await getShareCardsById(id);
     await saveShareCards(shareCards.copyWith(expectedReturnDate: newReturnDate));
  }

  // Filtre les prêts par status
  Future<List<ShareCards>> getByStatus(ShareCardsStatus status) async {
    final all = await getAllShareCards();
    return all.where((sc) => sc.status == status).toList();
  }

  Future<int> getNumberOfCurrentLent() async
  {
    final userId = await _getUserId();
    final all = await getAllShareCards();
    return all.where((sc) => sc.lenderId == userId && sc.returnedAt == null).toList().length;
  }

  Future<int> getNumberOfCurrentBorrow() async
  {
    final userId = await _getUserId();
    final all = await getAllShareCards();
    return all.where((sc) => sc.applicantId == userId && sc.status != ShareCardsStatus.returned).toList().length;
  }

  Future<int> getNumberOfLent() async{
    final userId = await _getUserId();
    final all = await getAllShareCards();
    return all.where((sc) => sc.lenderId == userId).toList().length;
  }

  Future<int> getNumberOfBorrow() async{
    final userId = await _getUserId();
    final all = await getAllShareCards();
    return all.where((sc) => sc.applicantId != userId).toList().length;
  }

  Future<List<ShareCards>> getLentCards() async {
    final userId = await _getUserId();
    final all = await getAllShareCards();
    return all.where((sc) => sc.lenderId == userId && sc.status != ShareCardsStatus.returned).toList();
  }

  Future<List<ShareCards>> getBorrowedCards() async {
    final userId = await _getUserId();
    final all = await getAllShareCards();
    return all.where((sc) => sc.applicantId == userId  && sc.status != ShareCardsStatus.returned).toList();
  }

  Future<void> saveShareCards(ShareCards shareCards) async {
    await repository.saveShareCards(shareCards);
  }

  Future<void> deleteShareCards(String id) async {
    await repository.deleteShareCards(id);
  }

  Future<List<ShareCards>> getAllShareCards() async {
    return await repository.getAllShareCards();
  }

  Future<ShareCards> getShareCardsById(String id) async {
    return await repository.getShareCardsById(id);
  }

  /*Future<void> updateShareCards(ShareCards shareCards) async {
    await localRepository.updateShareCards(shareCards);
  }*/
}
