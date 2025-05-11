import 'dart:convert';
import 'package:cb011999/models/blog.dart';
import 'package:http/http.dart' as http;
import '../services/token_service.dart';

class BlogService {
  static const String baseUrl = 'http://139.59.116.107/api';

  Future<Map<String, String>> get _headers async {
    final token = await TokenService().getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<List<Blog>> getAllBlogs() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/blogs'),
        headers: await _headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          final List<dynamic> blogs = responseData['data'];
          return blogs.map((json) => Blog.fromJson(json)).toList();
        } else {
          throw Exception('API request failed: ${responseData['status']}');
        }
      } else {
        throw Exception('Failed to load blogs: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load blogs: $e');
    }
  }

  Future<Blog> getBlogById(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/blogs/$id'),
        headers: await _headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          return Blog.fromJson(responseData['data']);
        } else {
          throw Exception('API request failed: ${responseData['status']}');
        }
      } else {
        throw Exception('Failed to load blog: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load blog: $e');
    }
  }
}
