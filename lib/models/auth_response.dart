// title: "Authentication Response Model"
// filepath: /Users/hardcandy/rust_projects/flutter_smart_notes_oauth/lib/models/auth_response.dart
import 'user.dart';

class AuthResponse {
  final String token;
  final User user;

  AuthResponse({
    required this.token,
    required this.user,
  });
}
