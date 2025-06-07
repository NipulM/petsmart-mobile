import 'dart:convert';
import 'package:http/http.dart' as http;
import 'token_service.dart';

class UserService {
  static const String baseUrl = 'http://139.59.116.107/api';
  final TokenService _tokenService = TokenService();

  // Get auth headers
  Future<Map<String, String>> _getAuthHeaders() async {
    final token = await _tokenService.getToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // Register user with the API
  Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print('API Registration error: $e');
      return false;
    }
  }

  // Login user with the API
  Future<Map<String, dynamic>?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        
        // Save token and user data
        await _tokenService.saveToken(responseData['token']);
        await _tokenService.saveUserData(responseData['user']);
        
        return responseData;
      }
      return null;
    } catch (e) {
      print('API Login error: $e');
      return null;
    }
  }

  // Logout user
  Future<void> logout() async {
    try {
      final headers = await _getAuthHeaders();
      await http.post(
        Uri.parse('$baseUrl/logout'),
        headers: headers,
      );
    } finally {
      await _tokenService.clearToken();
    }
  }

  // Get user profile
  Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      final headers = await _getAuthHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/user'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return null;
    } catch (e) {
      print('Get user profile error: $e');
      return null;
    }
  }

  // Update user profile
  Future<bool> updateUserProfile({String? phone, String? address}) async {
    try {
      print('Updating user profile with phone: $phone and address: $address');

      final headers = await _getAuthHeaders();
      final response = await http.put(
        Uri.parse('$baseUrl/user/profile'),
        headers: headers,
        body: jsonEncode({
          if (phone != null) 'phone': phone,
          if (address != null) 'address': address,
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Update user profile error: $e');
      return false;
    }
  }
}
