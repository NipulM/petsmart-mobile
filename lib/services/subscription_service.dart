import 'dart:convert';
import 'package:cb011999/models/subscription.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class SubscriptionService {
  static const String baseUrl =
      'https://ap-southeast-1.aws.data.mongodb-api.com/app/data-skoohxb/endpoint/data/v1';
  static const String apiKey =
      'dXqLJz0zrvJtkU9CtvhxpQvuNQYLUwj68Wqb68BYLURpSkygPD2jGzWAJQjvHVnn';

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Access-Control-Request-Headers': '*',
        'api-key': apiKey,
      };

  Future<List<Subscription>> getAllSubscriptions() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/action/find'),
        headers: _headers,
        body: json.encode({
          "collection": "subscriptions",
          "database": "petsmart",
          "dataSource": "PetsmartCluster",
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> documents = responseData['documents'] ?? [];
        return documents.map((json) => Subscription.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load subscriptions: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load subscriptions: $e');
    }
  }

  Future<Subscription> getSubscriptionById(String id) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/action/findOne'),
        headers: _headers,
        body: json.encode({
          "collection": "subscriptions",
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
          throw Exception('Subscription not found');
        }
        return Subscription.fromJson(document);
      } else {
        throw Exception('Failed to load subscription: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load subscription: $e');
    }
  }
}
