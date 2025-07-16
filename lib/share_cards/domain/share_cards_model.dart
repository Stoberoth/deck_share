class ShareCards {
  String? id = "";
  final String lender;
  final String applicant;
  final List<String> lendingCards;

  ShareCards({
    this.id,
    required this.lender,
    required this.applicant,
    required this.lendingCards,
  });

  factory ShareCards.fromJson(Map<String, dynamic> json) {
    return ShareCards(
      id: json["id"],
      lender: json["lender"],
      applicant: json["applicant"],
      lendingCards: json["lendingCards"],
    );
  }

  Map<String, dynamic> toJson()
  {
    return {
      'id': id,
      'lender': lender,
      'applicant': applicant,
      'lendingCards': lendingCards,
    };
  }
}
