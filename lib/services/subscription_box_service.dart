import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/subscription_box.dart';
import '../services/token_service.dart';

class SubscriptionBoxService {
  static const String baseUrl = 'http://139.59.116.107/api';

  Future<Map<String, String>> get _headers async {
    final token = await TokenService().getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<List<SubscriptionBox>> getSubscriptionBoxes() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/subscription-boxes'),
        headers: await _headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        return responseData.map((json) => SubscriptionBox.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load subscription boxes: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load subscription boxes: $e');
    }
  }
} 