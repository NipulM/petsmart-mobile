import 'dart:convert';
import 'package:cb011999/models/order.dart';
import 'package:http/http.dart' as http;
import '../services/token_service.dart';

class OrderService {
  static const String baseUrl = 'http://139.59.116.107/api';

  Future<Map<String, String>> get _headers async {
    final token = await TokenService().getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Order> createOrder(Order order) async {
    try {
      print(order.name);
      print(order.email);
      print(order.phone_number);
      print(order.address);
      print(order.order_items);
      print(order.total_amount);
      print(order.status);
      print(order.created_at);
      print(order.delivered_at);

      final response = await http.post(
        Uri.parse('$baseUrl/orders'),
        headers: await _headers,
        body: json.encode({
          'name': order.name,
          'email': order.email,
          'phone_number': order.phone_number,
          'address': order.address,
          'order_items':
              order.order_items.map((item) => item.toJson()).toList(),
          'total_amount': order.total_amount,
          'status': order.status,
          'created_at': order.created_at,
          'delivered_at': order.delivered_at,
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(
            'Failed to create order. Status code: ${response.statusCode}');
      }

      final responseData = json.decode(response.body);
      print('API Response: $responseData'); // Debug print

      // Check if the order was saved successfully
      if (responseData['status'] == 'success') {
        return order; // Return the original order object
      } else {
        throw Exception('Failed to create order: ${responseData['message']}');
      }
    } catch (e) {
      print('Order creation error: $e');
      throw Exception('Failed to create order: $e');
    }
  }
}
