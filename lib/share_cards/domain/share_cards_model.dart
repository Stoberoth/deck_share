import 'package:scryfall_api/scryfall_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'share_cards_model.freezed.dart';
part 'share_cards_model.g.dart';

enum ShareCardsStatus{
  active, // prêt en cours
  returned, // prêt rendu
  overdue, // prêt en retard
}

List<Map<String, dynamic>> _lendingCardsToJson(List<MtgCard> cards)
{
  return cards.map((card) => card.toJson()).toList();
}

List<MtgCard> _lendingCardsFromJson(List<dynamic> json)
{
  return json.map((item) => MtgCard.fromJson(item as Map<String, dynamic>)).toList();
}

@freezed
abstract class ShareCards with _$ShareCards
{
  const ShareCards._();

  const factory ShareCards({
  String? id, 
  String? title, 
  DateTime? expectedReturnDate,
  DateTime? returnedAt,
  ShareCardsStatus? status,
  String? notes,
  required String lender,
  required String applicant,
  @JsonKey(fromJson: _lendingCardsFromJson, toJson: _lendingCardsToJson)
  required List<MtgCard> lendingCards,
  DateTime? lendingDate
  }) = _ShareCards;

  factory ShareCards.fromJson(Map<String, dynamic> json) => _$ShareCardsFromJson(json);

  bool get isOverdue {
    if(status == ShareCardsStatus.returned) return false;
    if(expectedReturnDate == null) return false;
    return DateTime.now().isAfter(expectedReturnDate!);
  }
} 
