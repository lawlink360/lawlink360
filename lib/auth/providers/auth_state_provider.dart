import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:lawlink360/auth/models/auth_state.dart';
import 'auth_provider.dart';

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return const AuthState(
        status: AuthStatus.authenticated,
      );
    }

    return const AuthState(
      status: AuthStatus.unauthenticated,
    );
  }

  // =========================
  // EMAIL / PASSWORD LOGIN
  // =========================
  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(
      status: AuthStatus.loading,
      errorMessage: null,
    );

    try {
      await ref.read(authRepositoryProvider).login(
        email: email,
        password: password,
      );

      state = state.copyWith(
        status: AuthStatus.authenticated,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      );

      // IMPORTANT:
      // Send the error back to LoginScreen so it does
      // NOT continue to biometric/role selection.
      rethrow;
    }
  }

  // =========================
  // GOOGLE SIGN IN
  // =========================
  Future<void> signInWithGoogle() async {
    state = state.copyWith(
      status: AuthStatus.loading,
      errorMessage: null,
    );

    try {
      await ref
          .read(authRepositoryProvider)
          .signInWithGoogle();

      state = state.copyWith(
        status: AuthStatus.authenticated,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      );

      rethrow;
    }
  }

  // =========================
  // REGISTER
  // =========================
  Future<void> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    state = state.copyWith(
      status: AuthStatus.loading,
      errorMessage: null,
    );

    try {
      await ref.read(authRepositoryProvider).register(
        fullName: fullName,
        email: email,
        phone: phone,
        password: password,
      );

      state = state.copyWith(
        status: AuthStatus.authenticated,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      );

      rethrow;
    }
  }

  // =========================
  // RESET PASSWORD
  // =========================
  Future<void> resetPassword(String email) async {
    state = state.copyWith(
      status: AuthStatus.loading,
      errorMessage: null,
    );

    try {
      await ref
          .read(authRepositoryProvider)
          .forgotPassword(email);

      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      );

      rethrow;
    }
  }

  // =========================
  // SAVE ROLE
  // =========================
  Future<void> saveRole(String role) async {
    await ref
        .read(authRepositoryProvider)
        .saveRole(role);
  }

  // =========================
  // LOGOUT
  // =========================
  Future<void> logout() async {
    await ref
        .read(authRepositoryProvider)
        .logout();

    state = state.copyWith(
      status: AuthStatus.unauthenticated,
      errorMessage: null,
    );
  }
}

// =========================
// AUTH STATE PROVIDER
// =========================
final authStateProvider =
    NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);