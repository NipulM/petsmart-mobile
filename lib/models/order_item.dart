class OrderItem {
  final String productId;
  final String name;
  final double price;
  final int quantity;
  final String imageUrl;

  OrderItem({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    // Handle both formats of order items
    String productId = json['product_id'] ?? json['id']?.toString() ?? '';
    String imageUrl = json['image_url'] ?? json['imageUrl'] ?? '';
    
    return OrderItem(
      productId: productId,
      name: json['name'] ?? '',
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
      imageUrl: imageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'name': name,
      'price': price,
      'quantity': quantity,
      'image_url': imageUrl,
    };
  }
} 