import 'package:scryfall_api/scryfall_api.dart';

enum ShareCardsStatus{
  active, // prêt en cours
  returned, // prêt rendu
  overdue, // prêt en retard
}

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

  List<MtgCard> get lengingCards => lendingCards;

  factory ShareCards.fromJson(Map<String, dynamic> json) {
    return ShareCards(
      id: json["id"],
      title: json["title"],
      expectedReturnDate: json["expectedRetrunDate"],
      returnedAt: json["returnedAt"],
      status: json["status"],
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
      'expectedReturnDate': expectedReturnDate,
      'returnedAt': returnedAt,
      'status': status,
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
