// This is a basic Flutter widget test for Smart Notes OAuth app.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:smart_notes_oauth/main.dart';
import 'package:smart_notes_oauth/models/user.dart';
import 'package:smart_notes_oauth/models/auth_response.dart';

void main() {
  group('SmartNotesApp Tests', () {
    testWidgets('SmartNotesApp creates successfully', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const SmartNotesApp());

      // Verify that the app builds without errors
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });

  group('User Model Tests', () {
    test('User.fromMap creates user correctly', () {
      // Arrange
      final userData = {
        'id': '123',
        'email': 'test@example.com',
        'fullName': 'Test User',
        'avatar': 'https://example.com/avatar.jpg',
        'googleId': 'google123',
        'isEmailVerified': true,
      };

      // Act
      final user = User.fromMap(userData);

      // Assert
      expect(user.id, '123');
      expect(user.email, 'test@example.com');
      expect(user.fullName, 'Test User');
      expect(user.avatar, 'https://example.com/avatar.jpg');
      expect(user.googleId, 'google123');
      expect(user.isEmailVerified, true);
    });

    test('User.toJson converts user to JSON string', () {
      // Arrange
      final user = User(
        id: '123',
        email: 'test@example.com',
        fullName: 'Test User',
        avatar: 'https://example.com/avatar.jpg',
        googleId: 'google123',
        isEmailVerified: true,
      );

      // Act
      final jsonString = user.toJson();

      // Assert
      expect(jsonString, isA<String>());
      expect(jsonString.contains('test@example.com'), true);
      expect(jsonString.contains('Test User'), true);
    });

    test('User.fromJson creates user from JSON string', () {
      // Arrange
      const jsonString = '''
      {
        "id": "123",
        "email": "test@example.com", 
        "fullName": "Test User",
        "avatar": "https://example.com/avatar.jpg",
        "googleId": "google123",
        "isEmailVerified": true
      }
      ''';

      // Act
      final user = User.fromJson(jsonString);

      // Assert
      expect(user.id, '123');
      expect(user.email, 'test@example.com');
      expect(user.fullName, 'Test User');
      expect(user.isEmailVerified, true);
    });
  });

  group('AuthResponse Model Tests', () {
    test('AuthResponse creates correctly', () {
      // Arrange
      final user = User(
        id: '123',
        email: 'test@example.com',
        fullName: 'Test User',
        isEmailVerified: true,
      );

      // Act
      final authResponse = AuthResponse(
        token: 'jwt-token-123',
        user: user,
      );

      // Assert
      expect(authResponse.token, 'jwt-token-123');
      expect(authResponse.user.id, '123');
      expect(authResponse.user.email, 'test@example.com');
    });
  });
}
