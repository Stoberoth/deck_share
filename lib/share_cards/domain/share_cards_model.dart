import 'package:scryfall_api/scryfall_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'share_cards_model.freezed.dart';
part 'share_cards_model.g.dart';

enum ShareCardsStatus{
  active, // prêt en cours
  returned, // prêt rendu
  overdue, // prêt en retard
}


@freezed
abstract class ShareCards with _$ShareCards
{
  const ShareCards._();

  const factory ShareCards({required String id, 
  String? title, 
  DateTime? expectedReturnDate,
  DateTime? returnedAt,
  ShareCardsStatus? status,
  String? notes,
  required String lender,
  required String applicant,
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

/*
class ShareCards {
  String? id;
  final String? title; // nom du prêt
  final DateTime? expectedReturnDate; // date de retour prévue
  final DateTime? returnedAt; // date de retour effective
  final ShareCardsStatus status;
  final String? notes; 
  final String lender;
  final String applicant;
  final List<MtgCard> lendingCards;
  final DateTime? lendingDate;

  ShareCards({
    this.id,
    this.title,
    this.expectedReturnDate,
    this.returnedAt,
    this.status = ShareCardsStatus.active,
    this.notes,
    required this.lender,
    required this.applicant,
    required this.lendingCards,
    this.lendingDate,
  });

  factory ShareCards.fromJson(Map<String, dynamic> json) {
    return ShareCards(
      id: json["id"],
      title: json["title"],
      expectedReturnDate: json["expectedReturnDate"] != null ? DateTime.parse(json["expectedReturnDate"] as String): null,
      returnedAt: json["returnedAt"] != null ? DateTime.parse(json['returnedAt'] as String) : null,
      status: ShareCardsStatus.values.byName(json["status"]),
      notes: json["notes"],
      lender: json["lender"],
      applicant: json["applicant"],
      lendingCards: (json['lendingCards'] as List)
        .map((item) => MtgCard.fromJson(item as Map<String, dynamic>))
        .toList(),
      lendingDate: json['lendingDate'] != null 
        ? DateTime.parse(json['lendingDate'] as String)
        : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'expectedReturnDate': expectedReturnDate?.toIso8601String(),
      'returnedAt': returnedAt?.toIso8601String(),
      'status': status.name,
      'notes': notes,
      'lender': lender,
      'applicant': applicant,
      'lendingCards': lendingCards.map((card) => card.toJson()).toList(),
      'lendingDate': lendingDate?.toIso8601String(),
    };
  }

  bool get isOverdue {
    if(status == ShareCardsStatus.returned) return false;
    if(expectedReturnDate == null) return false;
    return DateTime.now().isAfter(expectedReturnDate!);
  }
}
*/
