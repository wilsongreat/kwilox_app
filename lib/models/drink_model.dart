class Drink {
  final String? id;
  final String name;
  final String description;
  final double price;
  final int drinkNumber;
  final String imageUrl;

  Drink({
    required this.name,
    required this.description,
    required this.price,
    required this.drinkNumber,
    required this.imageUrl,
    this.id,
  });

  Map<String, dynamic> toMap(String id) {
    return {
      'name': name,
      'id': id,
      'description': description,
      'price': price,
      'drinkNumber': drinkNumber,
      'imageUrl': imageUrl,
    };
  }

  Drink.fromMap(
    Map<String, dynamic> map,
  )   : name = map['name'] ?? "",
        id = map["id"] ?? '',
        drinkNumber = map['drinkNumber'] ?? 0,
        description = map['description'] ?? "",
        price = map['price'] ?? 0.0,
        imageUrl = map['imageUrl'] ?? "";
}
