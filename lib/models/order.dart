import 'package:cb011999/models/order_item.dart';

class Order {
  final String name;
  final String email;
  final String phone_number;
  final String address;
  final List<OrderItem> order_items;
  final double total_amount;
  final String status;
  final String created_at;
  final String? delivered_at;

  Order({
    required this.name,
    required this.email,
    required this.phone_number,
    required this.address,
    required this.order_items,
    required this.total_amount,
    required this.status,
    required this.created_at,
    this.delivered_at,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone_number: json['phone_number'] ?? '',
      address: json['address'] ?? '',
      order_items: (json['order_items'] as List)
          .map((item) => OrderItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      total_amount: (json['total_amount'] as num).toDouble(),
      status: json['status'] ?? 'pending',
      created_at: json['created_at'] ?? '',
      delivered_at: json['delivered_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone_number': phone_number,
      'address': address,
      'order_items': order_items.map((item) => item.toJson()).toList(),
      'total_amount': total_amount,
      'status': status,
      'created_at': created_at,
      if (delivered_at != null) 'delivered_at': delivered_at,
    };
  }
}
