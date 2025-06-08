class Favorite {
  final String productId;
  final String name;
  final double price;
  final String imageUrl;
  final String category;
  final String description;

  Favorite({
    required this.productId,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'description': description,
    };
  }

  factory Favorite.fromMap(Map<String, dynamic> map) {
    return Favorite(
      productId: map['productId'],
      name: map['name'],
      price: map['price'],
      imageUrl: map['imageUrl'],
      category: map['category'],
      description: map['description'],
    );
  }
} 