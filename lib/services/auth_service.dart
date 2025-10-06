// title: "Google OAuth Authentication Service"
// filepath: /Users/hardcandy/rust_projects/flutter_smart_notes_oauth/lib/services/auth_service.dart
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import 'backend_service.dart';

class AuthService extends ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
  );

  final BackendService _backendService = BackendService();

  User? _currentUser;
  String? _jwtToken;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  User? get currentUser => _currentUser;
  String? get jwtToken => _jwtToken;
  bool get isLoggedIn => _currentUser != null && _jwtToken != null;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  AuthService() {
    _loadStoredAuth();
  }

  // 🚀 Simple Google Sign-In Method
  Future<bool> signInWithGoogle() async {
    try {
      _setLoading(true);
      _clearError();

      print('🔐 Starting Google sign-in...');

      // Step 1: Sign in with Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        print('❌ User cancelled Google sign-in');
        return false;
      }

      print('✅ Google sign-in successful: ${googleUser.email}');

      // Step 2: Get Google auth tokens
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      if (googleAuth.idToken == null) {
        throw Exception('Failed to get Google ID token');
      }

      print('🔑 Got Google ID token');

      // Step 3: Send to your Rust backend
      final authResponse =
          await _backendService.loginWithGoogle(googleAuth.idToken!);

      if (authResponse != null) {
        _currentUser = authResponse.user;
        _jwtToken = authResponse.token;

        // Step 4: Save tokens for next app launch
        await _saveAuth();

        print('🎉 Authentication complete! Welcome ${_currentUser!.fullName}');

        notifyListeners();
        return true;
      } else {
        throw Exception('Backend authentication failed');
      }
    } catch (error) {
      print('❌ Google sign-in failed: $error');
      _setError('Sign-in failed: $error');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // 🚪 Sign Out Method
  Future<void> signOut() async {
    try {
      print('🚪 Signing out...');

      // Sign out from Google
      await _googleSignIn.signOut();

      // Clear local data
      _currentUser = null;
      _jwtToken = null;

      // Clear stored data
      await _clearStoredAuth();

      print('✅ Signed out successfully');
      notifyListeners();
    } catch (error) {
      print('❌ Sign-out failed: $error');
      _setError('Sign-out failed: $error');
    }
  }

  // 💾 Save authentication data
  Future<void> _saveAuth() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      if (_jwtToken != null) {
        await prefs.setString('jwt_token', _jwtToken!);
      }

      if (_currentUser != null) {
        await prefs.setString('user_data', _currentUser!.toJson());
      }

      print('💾 Auth data saved');
    } catch (error) {
      print('❌ Failed to save auth data: $error');
    }
  }

  // 📱 Load stored authentication data
  Future<void> _loadStoredAuth() async {
    try {
      _setLoading(true);

      final prefs = await SharedPreferences.getInstance();

      _jwtToken = prefs.getString('jwt_token');
      final userDataString = prefs.getString('user_data');

      if (_jwtToken != null && userDataString != null) {
        _currentUser = User.fromJson(userDataString);
        print('📱 Loaded stored auth for: ${_currentUser!.email}');
      }

      notifyListeners();
    } catch (error) {
      print('❌ Failed to load stored auth: $error');
    } finally {
      _setLoading(false);
    }
  }

  // 🗑️ Clear stored authentication data
  Future<void> _clearStoredAuth() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('jwt_token');
      await prefs.remove('user_data');
      print('🗑️ Cleared stored auth data');
    } catch (error) {
      print('❌ Failed to clear stored auth: $error');
    }
  }

  // Helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
