import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  UserModel? _user;

  UserModel? get user => _user;
  bool get isAuthenticated => _user != null;

  // Method to handle sign up
  Future<void> signUp(String email, String password) async {
    try {
      _user = await _authService.signUp(email, password);
      notifyListeners();
    } catch (e) {
      throw e.toString();
    }
  }

  // Method to handle sign in
  Future<void> signIn(String email, String password) async {
    try {
      _user = await _authService.signIn(email, password);
      notifyListeners();
    } catch (e) {
      throw e.toString();
    }
  }

  // Method to sign out
  Future<void> signOut() async {
    await _authService.signOut();
    _user = null;
    notifyListeners();
  }

  // Check authentication status
  Future<void> checkAuthStatus() async {
    final currentUser = _authService.currentUser;
    if (currentUser != null) {
      _user = UserModel(
        id: currentUser.uid,
        email: currentUser.email ?? '',
      );
    }
    Future.microtask(() => notifyListeners());
  }

  Future<void> resetPassword(String email) async {
    try {
      await _authService.resetPassword(email);
    } catch (e) {
      throw e.toString();
    }
  }
}
