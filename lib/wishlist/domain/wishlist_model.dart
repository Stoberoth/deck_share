class WishlistModel {
  final String id;
  final String name;
  final List<String> cards;
  final bool isShared;

  WishlistModel({
    required this.id,
    required this.name,
    required this.cards,
    required this.isShared,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) {
    return WishlistModel(
      id: json['id'],
      name: json['name'],
      cards: json['cards'],
      isShared: json['isShared'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'cards': cards,
      'isShared': isShared,
    };
  }
}



