import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  static const String _tokenKey = 'api_token';
  static const String _userDataKey = 'user_data';
  
  // Save token to persistent storage
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // Get token from storage
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Clear token (for logout)
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userDataKey);
  }

  // Save user data
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userDataKey, userData.toString());
  }

  // Get user data
  Future<String?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userDataKey);
  }
} 