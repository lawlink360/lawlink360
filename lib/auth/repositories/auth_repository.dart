import 'package:firebase_auth/firebase_auth.dart';

import '../services/auth_service.dart';

class AuthRepository {
  final AuthService authService;

  AuthRepository(this.authService);

  // Auth state changes stream
  Stream<User?> get authStateChanges =>
      authService.authStateChanges;

  // Login
  Future<UserCredential> login({
    required String email,
    required String password,
  }) {
    return authService.signIn(
      email: email,
      password: password,
    );
  }

  // Register
  Future<void> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) {
    return authService.signUp(
      fullName: fullName,
      email: email,
      phone: phone,
      password: password,
    );
  }

  // Google Sign In
  Future<void> signInWithGoogle() {
    return authService.signInWithGoogle();
  }

  // Logout
  Future<void> logout() {
    return authService.signOut();
  }

  // Forgot Password
  Future<void> forgotPassword(String email) {
    return authService.resetPassword(email);
  }

  // Save Role
  Future<void> saveRole(String role) {
    return authService.saveRole(role);
  }

  // Get User Role
  Future<String?> getUserRole(String uid) {
    return authService.getUserRole(uid);
  }

  // Current User
  User? get currentUser => authService.currentUser;

  // Login Status
  bool get isLoggedIn => authService.isLoggedIn;
}