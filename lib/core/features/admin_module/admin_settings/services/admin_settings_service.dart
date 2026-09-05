import 'package:lawlink360/core/features/admin_module/admin_settings/data/mock/admin_settings_mock_data.dart';
import 'package:lawlink360/core/features/admin_module/admin_settings/models/admin_permission_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_settings/models/admin_settings_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_settings/models/system_settings_model.dart';

class AdminSettingsService {
  AdminSettingsService._();

  static final AdminSettingsService instance = AdminSettingsService._();

  Future<AdminSettingsModel> fetchAdminSettings() async {
    await _simulateDelay();
    return AdminSettingsMockData.getAdminSettings();
  }

  Future<SystemSettingsModel> fetchSystemSettings() async {
    await _simulateDelay();
    return AdminSettingsMockData.getSystemSettings();
  }

  Future<List<AdminPermissionModel>> fetchPermissions() async {
    await _simulateDelay();
    return AdminSettingsMockData.getPermissions();
  }

  Future<AdminSettingsModel> updateAdminSettings(
    AdminSettingsModel settings,
  ) async {
    await _simulateDelay();
    return settings.copyWith(
      updatedAt: DateTime.now(),
    );
  }

  Future<SystemSettingsModel> updateSystemSettings(
    SystemSettingsModel settings,
  ) async {
    await _simulateDelay();
    return settings.copyWith(
      updatedAt: DateTime.now(),
    );
  }

  Future<AdminSettingsModel> setMaintenanceMode(
    bool enabled,
  ) async {
    final settings = await fetchAdminSettings();

    return settings.copyWith(
      maintenanceMode: enabled,
      updatedAt: DateTime.now(),
    );
  }

  Future<SystemSettingsModel> setSystemMaintenanceMode(
    bool enabled,
  ) async {
    final settings = await fetchSystemSettings();

    return settings.copyWith(
      maintenanceMode: enabled,
      updatedAt: DateTime.now(),
    );
  }

  Future<AdminPermissionModel?> getPermissionById(
    String id,
  ) async {
    await _simulateDelay();

    for (final permission in AdminSettingsMockData.permissions) {
      if (permission.id == id) {
        return permission;
      }
    }

    return null;
  }

  Future<AdminPermissionModel?> getPermissionByKey(
    String key,
  ) async {
    await _simulateDelay();

    for (final permission in AdminSettingsMockData.permissions) {
      if (permission.key == key) {
        return permission;
      }
    }

    return null;
  }

  Future<List<AdminPermissionModel>> searchPermissions(
    String query,
  ) async {
    await _simulateDelay();

    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      return AdminSettingsMockData.getPermissions();
    }

    return AdminSettingsMockData.permissions.where((permission) {
      return permission.name.toLowerCase().contains(normalizedQuery) ||
          permission.key.toLowerCase().contains(normalizedQuery) ||
          permission.description.toLowerCase().contains(normalizedQuery) ||
          permission.category.toLowerCase().contains(normalizedQuery);
    }).toList();
  }

  Future<List<AdminPermissionModel>> filterPermissionsByCategory(
    String category,
  ) async {
    await _simulateDelay();

    if (category == 'All') {
      return AdminSettingsMockData.getPermissions();
    }

    return AdminSettingsMockData.permissions
        .where(
          (permission) => permission.category == category,
        )
        .toList();
  }

  Future<int> getTotalPermissions() async {
    await _simulateDelay();
    return AdminSettingsMockData.permissions.length;
  }

  Future<int> getEnabledPermissions() async {
    await _simulateDelay();

    return AdminSettingsMockData.permissions
        .where((permission) => permission.isEnabled)
        .length;
  }

  Future<int> getDisabledPermissions() async {
    await _simulateDelay();

    return AdminSettingsMockData.permissions
        .where((permission) => !permission.isEnabled)
        .length;
  }

  Future<Map<String, int>> getPermissionSummary() async {
    await _simulateDelay();

    final permissions = AdminSettingsMockData.permissions;

    return {
      'total': permissions.length,
      'enabled': permissions
          .where((permission) => permission.isEnabled)
          .length,
      'disabled': permissions
          .where((permission) => !permission.isEnabled)
          .length,
      'categories': permissions
          .map((permission) => permission.category)
          .toSet()
          .length,
    };
  }

  Future<void> resetMockData() async {
    await _simulateDelay();

    // Mock data is static for now.
    // Firebase persistence will be added in the backend phase.
  }

  Future<void> _simulateDelay() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 150),
    );
  }
}