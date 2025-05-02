class Product {
  final String? id; // MongoDB document ID
  final int productId;
  final String name;
  final String shortDescription;
  final double price;
  final int stockQuantity;
  final bool isSeasonal;
  final String imageUrl;
  final int categoryId;
  final String description;
  final bool isNew;

  Product({
    this.id,
    required this.productId,
    required this.name,
    required this.shortDescription,
    required this.price,
    required this.stockQuantity,
    required this.isSeasonal,
    required this.imageUrl,
    required this.categoryId,
    required this.description,
    required this.isNew,
  });

  // Convert Product instance to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'product_id': productId,
      'name': name,
      'short_description': shortDescription,
      'price': price,
      'stock_quantity': stockQuantity,
      'is_seasonal': isSeasonal,
      'image_url': imageUrl,
      'category_id': categoryId,
      'description': description,
      'is_new': isNew,
    };
  }

  // Create Product instance from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id']?.toString(),
      productId: json['product_id'],
      name: json['name'],
      shortDescription: json['short_description'],
      price: json['price'].toDouble(),
      stockQuantity: json['stock_quantity'],
      isSeasonal: json['is_seasonal'],
      imageUrl: json['image_url'],
      categoryId: json['category_id'],
      description: json['description'],
      isNew: json['is_new'],
    );
  }

  // Create a copy of Product with modified fields
  Product copyWith({
    String? id,
    int? productId,
    String? name,
    String? shortDescription,
    double? price,
    int? stockQuantity,
    bool? isSeasonal,
    String? imageUrl,
    int? categoryId,
    String? description,
    bool? isNew,
  }) {
    return Product(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      shortDescription: shortDescription ?? this.shortDescription,
      price: price ?? this.price,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      isSeasonal: isSeasonal ?? this.isSeasonal,
      imageUrl: imageUrl ?? this.imageUrl,
      categoryId: categoryId ?? this.categoryId,
      description: description ?? this.description,
      isNew: isNew ?? this.isNew,
    );
  }
}
