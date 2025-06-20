class Wishlist {
  final String id;
  final String name;
  final List<String> cards;

  Wishlist({
    required this.id,
    required this.name,
    required this.cards,
  });

  factory Wishlist.fromJson(Map<String, dynamic> json) {
    return Wishlist(
      id: json['id'],
      name: json['name'],
      cards: List<String>.from(json['cards']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'cards': cards,
    };
  }
}



