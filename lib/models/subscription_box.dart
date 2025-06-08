import 'package:intl/intl.dart';

class OrderItem {
  final int productId;
  final String name;
  final String shortDescription;
  final String price;
  final String stockQuantity;
  final bool isSeasonal;
  final String imageUrl;
  final String categoryId;
  final String description;
  final bool isNew;
  final int quantity;

  OrderItem({
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
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['product_id'],
      name: json['name'],
      shortDescription: json['short_description'],
      price: json['price'],
      stockQuantity: json['stock_quantity'],
      isSeasonal: json['is_seasonal'],
      imageUrl: json['image_url'],
      categoryId: json['category_id'],
      description: json['description'],
      isNew: json['is_new'],
      quantity: json['quantity'],
    );
  }
}

class SubscriptionBox {
  final int id;
  final int userId;
  final int subscriptionId;
  final String totalAmount;
  final List<OrderItem> orderItems;
  final DateTime startDate;
  final DateTime expiryDate;
  final String status;
  final DateTime createdAt;
  final String customerName;

  SubscriptionBox({
    required this.id,
    required this.userId,
    required this.subscriptionId,
    required this.totalAmount,
    required this.orderItems,
    required this.startDate,
    required this.expiryDate,
    required this.status,
    required this.createdAt,
    required this.customerName,
  });

  factory SubscriptionBox.fromJson(Map<String, dynamic> json) {
    return SubscriptionBox(
      id: json['id'],
      userId: json['user_id'],
      subscriptionId: json['subscription_id'],
      totalAmount: json['total_amount'],
      orderItems: (json['order_items'] as List)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      startDate: DateTime.parse(json['start_date']),
      expiryDate: DateTime.parse(json['expiry_date']),
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      customerName: json['customer_name'],
    );
  }

  int get remainingDays {
    final now = DateTime.now();
    return expiryDate.difference(now).inDays;
  }

  String get formattedExpiryDate {
    final DateFormat formatter = DateFormat('MMM dd, yyyy');
    return formatter.format(expiryDate);
  }

  String get formattedStartDate {
    final DateFormat formatter = DateFormat('MMM dd, yyyy');
    return formatter.format(startDate);
  }
} 