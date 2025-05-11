import 'dart:convert';
import 'package:cb011999/models/subscription.dart';
import 'package:http/http.dart' as http;
import '../services/token_service.dart';

class SubscriptionService {
  static const String baseUrl = 'http://139.59.116.107/api';

  Future<Map<String, String>> get _headers async {
    final token = await TokenService().getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<List<Subscription>> getAllSubscriptions() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/subscriptions'),
        headers: await _headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          final List<dynamic> subscriptions = responseData['data'];
          return subscriptions.map((json) => Subscription.fromJson(json)).toList();
        } else {
          throw Exception('API request failed: ${responseData['status']}');
        }
      } else {
        throw Exception('Failed to load subscriptions: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load subscriptions: $e');
    }
  }

  Future<Subscription> getSubscriptionById(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/subscriptions/$id'),
        headers: await _headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          return Subscription.fromJson(responseData['data']);
        } else {
          throw Exception('API request failed: ${responseData['status']}');
        }
      } else {
        throw Exception('Failed to load subscription: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load subscription: $e');
    }
  }
}
