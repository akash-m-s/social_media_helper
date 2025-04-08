import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';
import '../shared/disposible_email_domain_validator.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserModel?> signUp({
    required String email,
    required String password,
    required DisposableEmailValidator validator,
  }) async {
    if (validator.isDisposable(email)) {
      throw 'Invalid email domain.';
    }
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserModel(
        id: userCredential.user?.uid ?? '',
        email: userCredential.user?.email ?? '',
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw 'This email is already in use.';
      } else if (e.code == 'invalid-email') {
        throw 'Invalid email format.';
      } else if (e.code == 'weak-password') {
        throw 'Password must be at least 6 characters.';
      }
      throw e.message ?? 'Something went wrong.';
    } catch (e) {
      throw 'Something went wrong.';
    }
  }

  Future<UserModel?> signIn(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserModel(
        id: userCredential.user?.uid ?? '',
        email: userCredential.user?.email ?? '',
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw 'No user found with this email.';
      } else if (e.code == 'wrong-password') {
        throw 'Incorrect password.';
      }
      throw e.message ?? 'Something went wrong.';
    } catch (e) {
      throw 'Something went wrong.';
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw 'No user found with this email.';
      }
      throw e.message ?? 'Something went wrong.';
    } catch (e) {
      throw e.toString(); // Handle errors and rethrow
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> sendEmailVerification() async {
    try {
      final user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Something went wrong.';
    } catch (e) {
      throw e.toString(); // Handle errors and rethrow
    }
  }

  Future<bool> isEmailVerified() async {
    final user = _auth.currentUser;
    await user?.reload(); // Reload to get latest user data
    return user?.emailVerified ?? false;
  }

  User? get currentUser => _auth.currentUser;
}
