// title: "Backend Service for Rust GraphQL API"
// filepath: /Users/hardcandy/rust_projects/flutter_smart_notes_oauth/lib/services/backend_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/auth_response.dart';
import '../models/user.dart';

class BackendService {
  // 🦀 Your Rust backend URL
  static const String baseUrl = 'http://127.0.0.1:8000';
  static const String graphqlEndpoint = '$baseUrl/graphql';

  // 🔐 Send Google token to your Rust backend
  Future<AuthResponse?> loginWithGoogle(String googleIdToken) async {
    try {
      print('🔄 Sending Google token to Rust backend...');

      final response = await http.post(
        Uri.parse(graphqlEndpoint),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'query': '''
            mutation LoginWithGoogle(\$token: String!) {
              loginWithGoogle(googleToken: \$token) {
                token
                user {
                  id
                  email
                  fullName
                  avatar
                  googleId
                  isEmailVerified
                }
              }
            }
          ''',
          'variables': {
            'token': googleIdToken,
          },
        }),
      );

      print('📡 Backend response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData['errors'] != null) {
          throw Exception('GraphQL Error: ${jsonData['errors'][0]['message']}');
        }

        final loginData = jsonData['data']['loginWithGoogle'];

        if (loginData != null) {
          print('✅ Backend authentication successful!');

          return AuthResponse(
            token: loginData['token'],
            user: User.fromMap(loginData['user']),
          );
        } else {
          throw Exception('No login data received from backend');
        }
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }
    } catch (error) {
      print('❌ Backend login failed: $error');
      return null;
    }
  }

  // 📝 Make authenticated requests to your Rust backend
  Future<Map<String, dynamic>?> makeAuthenticatedRequest({
    required String query,
    Map<String, dynamic>? variables,
    required String jwtToken,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(graphqlEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
        body: jsonEncode({
          'query': query,
          'variables': variables ?? {},
        }),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData['errors'] != null) {
          throw Exception('GraphQL Error: ${jsonData['errors'][0]['message']}');
        }

        return jsonData['data'];
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }
    } catch (error) {
      print('❌ Authenticated request failed: $error');
      return null;
    }
  }

  // 📒 Get user's notes (example)
  Future<List<Map<String, dynamic>>?> getUserNotes(String jwtToken) async {
    final result = await makeAuthenticatedRequest(
      query: '''
        query GetMyNotes {
          notes {
            id
            title
            content
            createdAt
            updatedAt
          }
        }
      ''',
      jwtToken: jwtToken,
    );

    if (result != null && result['notes'] != null) {
      return List<Map<String, dynamic>>.from(result['notes']);
    }
    return null;
  }
}
