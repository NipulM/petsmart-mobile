import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  final String? userId;
  final String name;
  final String email;
  final String? bio;
  final String? preferences;
  final String? address;
  final String? phone;
  final String? petInfo;
  final DateTime createdAt;
  final String? role;

  User({
    this.userId,
    required this.name,
    required this.email,
    this.bio,
    this.preferences,
    this.address,
    this.phone,
    this.petInfo,
    required this.createdAt,
    this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'name': name,
      'email': email,
      'bio': bio,
      'preferences': preferences,
      'address': address,
      'phone': phone,
      'pet_info': petInfo,
      'created_at': createdAt.toIso8601String(),
      'role': role,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['user_id'],
      name: map['name'],
      email: map['email'],
      bio: map['bio'],
      preferences: map['preferences'],
      address: map['address'],
      phone: map['phone'],
      petInfo: map['pet_info'],
      createdAt: DateTime.parse(map['created_at']),
      role: map['role'],
    );
  }
}
