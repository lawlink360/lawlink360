import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/admin_module/admin_users/models/admin_user_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_users/services/admin_users_service.dart';

final adminUserDetailsProvider = NotifierProviderFamily<
    AdminUserDetailsNotifier,
    AsyncValue<AdminUserModel?>,
    String>(
  AdminUserDetailsNotifier.new,
);

class AdminUserDetailsNotifier
    extends FamilyNotifier<AsyncValue<AdminUserModel?>, String> {
  final AdminUsersService _service = const AdminUsersService();

  @override
  AsyncValue<AdminUserModel?> build(String userId) {
    Future.microtask(loadUser);

    return const AsyncValue.loading();
  }

  Future<void> loadUser() async {
    state = const AsyncValue.loading();

    try {
      final user = await _service.getUserById(arg);

      state = AsyncValue.data(user);
    } catch (error, stackTrace) {
      state = AsyncValue.error(
        error,
        stackTrace,
      );
    }
  }

  Future<void> refreshUser() async {
    await loadUser();
  }

  Future<void> updateStatus(String newStatus) async {
    final currentUser = state.valueOrNull;

    if (currentUser == null) {
      return;
    }

    final updatedUser = currentUser.copyWith(
      status: newStatus,
    );

    state = AsyncValue.data(updatedUser);
  }

  void clearUser() {
    state = const AsyncValue.data(null);
  }
}