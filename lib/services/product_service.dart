import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../services/token_service.dart';

class ProductService {
  static const String baseUrl = 'http://139.59.116.107/api';

  Future<Map<String, String>> get _headers async {
    final token = await TokenService().getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<List<Product>> getAllProducts() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products'),
        headers: await _headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          final List<dynamic> products = responseData['data'];
          return products.map((json) => Product.fromJson(json)).toList();
        } else {
          throw Exception('API request failed: ${responseData['status']}');
        }
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  Future<Product> getProductById(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/$id'),
        headers: await _headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          return Product.fromJson(responseData['data']);
        } else {
          throw Exception('API request failed: ${responseData['status']}');
        }
      } else {
        throw Exception('Failed to load product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load product: $e');
    }
  }

  Future<List<Product>> getProductsByFilter(
      String? categoryId, String? minPrice, String? maxPrice) async {
    try {
      final queryParams = <String, String>{};
      if (categoryId != null) queryParams['category'] = categoryId;
      if (minPrice != null) queryParams['minPrice'] = minPrice;
      if (maxPrice != null) queryParams['maxPrice'] = maxPrice;

      final uri =
          Uri.parse('$baseUrl/filter').replace(queryParameters: queryParams);

      final response = await http.get(
        uri,
        headers: await _headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          final List<dynamic> products = responseData['data'];
          return products.map((json) => Product.fromJson(json)).toList();
        } else {
          throw Exception('API request failed: ${responseData['status']}');
        }
      } else {
        throw Exception(
            'Failed to load filtered products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load filtered products: $e');
    }
  }
}
