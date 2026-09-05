
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/admin_module/admin_auth/models/admin_auth_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_auth/services/admin_auth_service.dart';

final adminAuthProvider =
    NotifierProvider<AdminAuthNotifier, AsyncValue<AdminAuthModel?>>(
  AdminAuthNotifier.new,
);

class AdminAuthNotifier
    extends Notifier<AsyncValue<AdminAuthModel?>> {
  final AdminAuthService _service = AdminAuthService.instance;

  @override
  AsyncValue<AdminAuthModel?> build() {
    return const AsyncValue.data(null);
  }

  AdminAuthModel? get currentAdmin => state.valueOrNull;

  bool get isAuthenticated =>
      currentAdmin?.isAuthenticated ?? false;

  bool get isActive =>
      currentAdmin?.isActive ?? false;

  String? get adminId => currentAdmin?.adminId;

  String? get adminEmail => currentAdmin?.email;

  String? get adminName => currentAdmin?.name;

  String? get roleId => currentAdmin?.roleId;

  String? get roleName => currentAdmin?.roleName;

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();

    try {
      final admin = await _service.login(
        email: email,
        password: password,
      );

      if (admin == null) {
        state = const AsyncValue.data(null);
        return false;
      }

      state = AsyncValue.data(admin);
      return true;
    } catch (error, stackTrace) {
      state = AsyncValue.error(
        error,
        stackTrace,
      );
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await _service.logout();
    } finally {
      state = const AsyncValue.data(null);
    }
  }

  Future<AdminAuthModel?> refreshAdmin() async {
    final admin = currentAdmin;

    if (admin == null) {
      return null;
    }

    try {
      final refreshedAdmin = await _service.getAdminById(
        admin.adminId,
      );

      if (refreshedAdmin == null) {
        state = const AsyncValue.data(null);
        return null;
      }

      final updatedAdmin = refreshedAdmin.copyWith(
        isAuthenticated: true,
        sessionStartedAt: admin.sessionStartedAt,
      );

      state = AsyncValue.data(updatedAdmin);

      return updatedAdmin;
    } catch (error, stackTrace) {
      state = AsyncValue.error(
        error,
        stackTrace,
      );
      return null;
    }
  }

  Future<bool> hasPermission(String permission) async {
    final admin = currentAdmin;

    if (admin == null || !admin.isAuthenticated || !admin.isActive) {
      return false;
    }

    return _service.hasPermission(
      roleId: admin.roleId,
      permission: permission,
    );
  }

  bool hasPermissionSync(String permission) {
    final admin = currentAdmin;

    if (admin == null || !admin.isAuthenticated || !admin.isActive) {
      return false;
    }

    final rolePermissions = {
      'role_super_admin': {
        'dashboard.view',
        'users.view',
        'users.manage',
        'lawyers.view',
        'lawyers.manage',
        'verification.view',
        'verification.manage',
        'appointments.view',
        'appointments.manage',
        'cases.view',
        'cases.manage',
        'payments.view',
        'payments.manage',
        'notifications.view',
        'notifications.manage',
        'content.view',
        'content.manage',
        'analytics.view',
        'reports.view',
        'activity.view',
        'settings.view',
        'settings.manage',
        'admin.manage',
      },
      'role_content_admin': {
        'dashboard.view',
        'content.view',
        'content.manage',
        'analytics.view',
        'reports.view',
        'activity.view',
      },
      'role_support_admin': {
        'dashboard.view',
        'users.view',
        'users.manage',
        'lawyers.view',
        'verification.view',
        'appointments.view',
        'appointments.manage',
        'notifications.view',
        'activity.view',
      },
    };

    return rolePermissions[admin.roleId]?.contains(permission) ?? false;
  }

  void clearError() {
    if (state.hasError) {
      state = AsyncValue.data(currentAdmin);
    }
  }
}
