
import 'package:lawlink360/core/features/admin_module/admin_auth/data/mock/admin_auth_mock_data.dart';
import 'package:lawlink360/core/features/admin_module/admin_auth/models/admin_auth_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_auth/models/admin_role_model.dart';

class AdminAuthService {
  AdminAuthService._();

  static final AdminAuthService instance = AdminAuthService._();

  Future<AdminAuthModel?> login({
    required String email,
    required String password,
  }) async {
    await _simulateDelay();

    final admin = AdminAuthMockData.getAdminByEmail(email);

    if (admin == null) {
      return null;
    }

    if (!admin.isActive) {
      return null;
    }

    if (password.isEmpty) {
      return null;
    }

    return admin.copyWith(
      isAuthenticated: true,
      lastLoginAt: DateTime.now(),
      sessionStartedAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  Future<bool> logout() async {
    await _simulateDelay();
    return true;
  }

  Future<AdminAuthModel?> getAdminById(String adminId) async {
    await _simulateDelay();
    return AdminAuthMockData.getAdminById(adminId);
  }

  Future<AdminAuthModel?> getAdminByEmail(String email) async {
    await _simulateDelay();
    return AdminAuthMockData.getAdminByEmail(email);
  }

  Future<List<AdminRoleModel>> getRoles() async {
    await _simulateDelay();
    return AdminAuthMockData.getRoles();
  }

  Future<AdminRoleModel?> getRoleById(String roleId) async {
    await _simulateDelay();
    return AdminAuthMockData.getRoleById(roleId);
  }

  Future<bool> hasPermission({
    required String roleId,
    required String permission,
  }) async {
    await _simulateDelay();

    final role = AdminAuthMockData.getRoleById(roleId);

    if (role == null || !role.isActive) {
      return false;
    }

    return role.permissions.contains(permission);
  }

  Future<bool> isAdminActive(String adminId) async {
    await _simulateDelay();

    final admin = AdminAuthMockData.getAdminById(adminId);

    return admin?.isActive ?? false;
  }

  Future<void> _simulateDelay() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 250),
    );
  }
}
