import 'package:scryfall_api/scryfall_api.dart';

class ShareCards {
  String? id;
  final String lender;
  final String applicant;
  final List<MtgCard> lendingCards;
  final DateTime? lendingDate;

  ShareCards({
    this.id,
    required this.lender,
    required this.applicant,
    required this.lendingCards,
    this.lendingDate,
  });

  List<MtgCard> get lengingCards => lendingCards;

  factory ShareCards.fromJson(Map<String, dynamic> json) {
    return ShareCards(
      id: json["id"],
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
      'lender': lender,
      'applicant': applicant,
      'lendingCards': lendingCards.map((card) => card.toJson()).toList(),
      'lendingDate': lendingDate?.toIso8601String(),
    };
  }
}
