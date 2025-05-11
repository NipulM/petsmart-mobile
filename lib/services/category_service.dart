import 'dart:convert';
import 'package:cb011999/models/category.dart';
import 'package:http/http.dart' as http;
import '../services/token_service.dart';

class CategoryService {
  static const String baseUrl = 'http://139.59.116.107/api';

  Future<Map<String, String>> get _headers async {
    final token = await TokenService().getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<List<Category>> getAllCategories() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/categories'),
        headers: await _headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          final List<dynamic> categories = responseData['data'];
          return categories.map((json) => Category.fromJson(json)).toList();
        } else {
          throw Exception('API request failed: ${responseData['status']}');
        }
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  Future<Category> getCategoryById(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/categories/$id'),
        headers: await _headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          return Category.fromJson(responseData['data']);
        } else {
          throw Exception('API request failed: ${responseData['status']}');
        }
      } else {
        throw Exception('Failed to load category: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load category: $e');
    }
  }
}
