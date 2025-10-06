// title: "User Data Model"
// filepath: /Users/hardcandy/rust_projects/flutter_smart_notes_oauth/lib/models/user.dart
import 'dart:convert';

class User {
  final String id;
  final String email;
  final String? fullName;
  final String? avatar;
  final String? googleId;
  final bool isEmailVerified;

  User({
    required this.id,
    required this.email,
    this.fullName,
    this.avatar,
    this.googleId,
    required this.isEmailVerified,
  });

  // Convert from API response
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      fullName: map['fullName'],
      avatar: map['avatar'],
      googleId: map['googleId'],
      isEmailVerified: map['isEmailVerified'] ?? false,
    );
  }

  // Convert to JSON for storage
  String toJson() {
    return jsonEncode({
      'id': id,
      'email': email,
      'fullName': fullName,
      'avatar': avatar,
      'googleId': googleId,
      'isEmailVerified': isEmailVerified,
    });
  }

  // Convert from stored JSON
  factory User.fromJson(String jsonString) {
    final map = jsonDecode(jsonString);
    return User.fromMap(map);
  }
}
