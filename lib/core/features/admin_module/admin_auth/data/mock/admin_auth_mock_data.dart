
import 'package:lawlink360/core/features/admin_module/admin_auth/models/admin_auth_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_auth/models/admin_role_model.dart';

class AdminAuthMockData {
  AdminAuthMockData._();

  static final DateTime _now = DateTime.now();

  static List<AdminRoleModel> getRoles() {
    return [
      AdminRoleModel(
        id: 'role_super_admin',
        name: 'Super Admin',
        description: 'Full access to all LawLink360 administration features.',
        permissions: const [
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
        ],
        createdAt: _now.subtract(const Duration(days: 180)),
        updatedAt: _now.subtract(const Duration(days: 5)),
      ),
      AdminRoleModel(
        id: 'role_content_admin',
        name: 'Content Admin',
        description: 'Manages legal content including laws, judgments, drafting, and procedures.',
        permissions: const [
          'dashboard.view',
          'content.view',
          'content.manage',
          'analytics.view',
          'reports.view',
          'activity.view',
        ],
        createdAt: _now.subtract(const Duration(days: 150)),
        updatedAt: _now.subtract(const Duration(days: 12)),
      ),
      AdminRoleModel(
        id: 'role_support_admin',
        name: 'Support Admin',
        description: 'Handles users, lawyers, appointments, and support-related administration.',
        permissions: const [
          'dashboard.view',
          'users.view',
          'users.manage',
          'lawyers.view',
          'verification.view',
          'appointments.view',
          'appointments.manage',
          'notifications.view',
          'activity.view',
        ],
        createdAt: _now.subtract(const Duration(days: 120)),
        updatedAt: _now.subtract(const Duration(days: 18)),
      ),
    ];
  }

  static List<AdminAuthModel> getAdmins() {
    return [
      AdminAuthModel(
        adminId: 'admin_001',
        email: 'admin@lawlink360.com',
        name: 'LawLink360 Administrator',
        roleId: 'role_super_admin',
        roleName: 'Super Admin',
        isActive: true,
        isAuthenticated: false,
        lastLoginAt: _now.subtract(const Duration(hours: 3)),
        createdAt: _now.subtract(const Duration(days: 180)),
        updatedAt: _now.subtract(const Duration(hours: 3)),
      ),
      AdminAuthModel(
        adminId: 'admin_002',
        email: 'content@lawlink360.com',
        name: 'Content Administrator',
        roleId: 'role_content_admin',
        roleName: 'Content Admin',
        isActive: true,
        isAuthenticated: false,
        lastLoginAt: _now.subtract(const Duration(days: 1)),
        createdAt: _now.subtract(const Duration(days: 150)),
        updatedAt: _now.subtract(const Duration(days: 1)),
      ),
      AdminAuthModel(
        adminId: 'admin_003',
        email: 'support@lawlink360.com',
        name: 'Support Administrator',
        roleId: 'role_support_admin',
        roleName: 'Support Admin',
        isActive: true,
        isAuthenticated: false,
        lastLoginAt: _now.subtract(const Duration(days: 2)),
        createdAt: _now.subtract(const Duration(days: 120)),
        updatedAt: _now.subtract(const Duration(days: 2)),
      ),
      AdminAuthModel(
        adminId: 'admin_004',
        email: 'inactive@lawlink360.com',
        name: 'Inactive Administrator',
        roleId: 'role_support_admin',
        roleName: 'Support Admin',
        isActive: false,
        isAuthenticated: false,
        lastLoginAt: _now.subtract(const Duration(days: 30)),
        createdAt: _now.subtract(const Duration(days: 200)),
        updatedAt: _now.subtract(const Duration(days: 30)),
      ),
    ];
  }

  static AdminAuthModel? getAdminByEmail(String email) {
    final normalizedEmail = email.trim().toLowerCase();

    for (final admin in getAdmins()) {
      if (admin.email.toLowerCase() == normalizedEmail) {
        return admin;
      }
    }

    return null;
  }

  static AdminAuthModel? getAdminById(String adminId) {
    for (final admin in getAdmins()) {
      if (admin.adminId == adminId) {
        return admin;
      }
    }

    return null;
  }

  static AdminRoleModel? getRoleById(String roleId) {
    for (final role in getRoles()) {
      if (role.id == roleId) {
        return role;
      }
    }

    return null;
  }
}
