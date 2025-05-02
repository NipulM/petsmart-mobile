import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  static const String baseUrl = 'https://ap-southeast-1.aws.data.mongodb-api.com/app/data-skoohxb/endpoint/data/v1';
  static const String apiKey = 'dXqLJz0zrvJtkU9CtvhxpQvuNQYLUwj68Wqb68BYLURpSkygPD2jGzWAJQjvHVnn'; 
  
  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Access-Control-Request-Headers': '*',
    'api-key': apiKey,
  };

  Future<List<Product>> getAllProducts() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/action/find'),
        headers: _headers,
        body: json.encode({
          "collection": "products",
          "database": "petsmart",
          "dataSource": "PetsmartCluster",
        }),
      );
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> documents = responseData['documents'] ?? [];
        return documents.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  Future<Product> getProductById(String id) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/action/findOne'),
        headers: _headers,
        body: json.encode({
          "collection": "products",
          "database": "petsmart",
          "dataSource": "PetsmartCluster",
          "filter": {
            "_id": {"\$oid": id}
          }
        }),
      );
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final document = responseData['document'];
        if (document == null) {
          throw Exception('Product not found');
        }
        return Product.fromJson(document);
      } else {
        throw Exception('Failed to load product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load product: $e');
    }
  }
} 