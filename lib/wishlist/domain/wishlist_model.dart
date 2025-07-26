import 'package:scryfall_api/scryfall_api.dart';

class Wishlist {
  String? id = "";
  final String name;
  final List<MtgCard> cards;

  Wishlist({this.id, required this.name, required this.cards});

  factory Wishlist.fromJson(Map<String, dynamic> json) {
    return Wishlist(
      id: json['id'],
      name: json['name'],
      cards: (json["cards"] as List)
          .map((item) => MtgCard.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'cards': cards.map((card) => card.toJson()).toList(),
    };
  }
}
