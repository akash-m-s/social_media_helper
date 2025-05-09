import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../shared/disposible_email_domain_validator.dart';

class AuthProvider with ChangeNotifier {
  final DisposableEmailValidator _emailValidator;
  final AuthService _authService = AuthService();
  AuthProvider(this._emailValidator);
  UserModel? _user;

  UserModel? get user => _user;
  bool get isAuthenticated => _user != null;

  // Method to handle sign up
  Future<void> signUp(String email, String password) async {
    try {
      _user = await _authService.signUp(
        email: email,
        password: password,
        validator: _emailValidator,
      );
      notifyListeners();
    } catch (e) {
      rethrow;
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
      final isEmailVerified = await _authService.isEmailVerified();
      if (!isEmailVerified) {
        _user = null;
        return;
      }
      _user = UserModel(
        id: currentUser.uid,
        email: currentUser.email ?? '',
      );
    }
    Future.microtask(() => notifyListeners());
  }

  Future<void> sendEmailVerification() async {
    try {
      await _authService.sendEmailVerification();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> isEmailVerified() async {
    return await _authService.isEmailVerified();
  }

  Future<void> resetPassword(String email) async {
    try {
      await _authService.resetPassword(email);
    } catch (e) {
      throw e.toString();
    }
  }
}
