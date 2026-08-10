import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_profile.dart';
import '../repositories/user_profile_repository.dart';
import '../../auth/providers/auth_state_provider.dart';
import '../../auth/models/auth_state.dart';

final userProfileRepositoryProvider =
    Provider<UserProfileRepository>((ref) {
  return UserProfileRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  );
});

class UserProfileNotifier extends AsyncNotifier<UserProfile> {
  @override
  Future<UserProfile> build() async {
    // Check auth state before building
    final authState = ref.watch(authStateProvider);

    if (authState.status != AuthStatus.authenticated) {
      return UserProfile.empty();
    }

    return ref
        .read(userProfileRepositoryProvider)
        .getCurrentUser();
  }

  Future<void> refreshProfile() async {
    final authState = ref.watch(authStateProvider);

    if (authState.status != AuthStatus.authenticated) {
      state = AsyncValue.data(UserProfile.empty());
      return;
    }

    state = const AsyncValue.loading();

    state = AsyncValue.data(
      await ref
          .read(userProfileRepositoryProvider)
          .getCurrentUser(),
    );
  }

  Future<void> updateRole(String role) async {
    final authState = ref.watch(authStateProvider);

    if (authState.status != AuthStatus.authenticated) {
      throw Exception('No authenticated user found. Please log in again.');
    }

    await ref
        .read(userProfileRepositoryProvider)
        .updateRole(role);

    await refreshProfile();
  }
}

final userProfileProvider =
    AsyncNotifierProvider<UserProfileNotifier, UserProfile>(
  UserProfileNotifier.new,
);