import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/admin_module/admin_settings/data/mock/admin_settings_mock_data.dart';
import 'package:lawlink360/core/features/admin_module/admin_settings/models/admin_permission_model.dart';

final adminPermissionProvider = NotifierProvider<
    AdminPermissionNotifier,
    AsyncValue<List<AdminPermissionModel>>>(
  AdminPermissionNotifier.new,
);

class AdminPermissionNotifier
    extends Notifier<AsyncValue<List<AdminPermissionModel>>> {
  List<AdminPermissionModel> _permissions = [];

  String _searchQuery = '';
  String _categoryFilter = 'All';

  @override
  AsyncValue<List<AdminPermissionModel>> build() {
    _permissions = AdminSettingsMockData.getPermissions();

    return AsyncValue.data(
      List<AdminPermissionModel>.from(_permissions),
    );
  }

  String get searchQuery => _searchQuery;

  String get categoryFilter => _categoryFilter;

  List<AdminPermissionModel> get permissions =>
      List<AdminPermissionModel>.unmodifiable(_permissions);

  List<AdminPermissionModel> get filteredPermissions {
    Iterable<AdminPermissionModel> result = _permissions;

    if (_searchQuery.trim().isNotEmpty) {
      final query = _searchQuery.trim().toLowerCase();

      result = result.where(
        (permission) =>
            permission.name.toLowerCase().contains(query) ||
            permission.key.toLowerCase().contains(query) ||
            permission.description.toLowerCase().contains(query) ||
            permission.category.toLowerCase().contains(query),
      );
    }

    if (_categoryFilter != 'All') {
      result = result.where(
        (permission) =>
            permission.category == _categoryFilter,
      );
    }

    return List<AdminPermissionModel>.unmodifiable(result);
  }

  List<String> get categories {
    final values = _permissions
        .map((permission) => permission.category)
        .toSet()
        .toList();

    values.sort();

    return ['All', ...values];
  }

  int get totalPermissions => _permissions.length;

  int get enabledPermissions =>
      _permissions.where((permission) => permission.isEnabled).length;

  int get disabledPermissions =>
      _permissions.where((permission) => !permission.isEnabled).length;

  void search(String query) {
    _searchQuery = query;
    _emitFiltered();
  }

  void setCategoryFilter(String category) {
    _categoryFilter = category;
    _emitFiltered();
  }

  void clearFilters() {
    _searchQuery = '';
    _categoryFilter = 'All';
    _emitFiltered();
  }

  AdminPermissionModel? getPermissionById(String id) {
    for (final permission in _permissions) {
      if (permission.id == id) {
        return permission;
      }
    }

    return null;
  }

  AdminPermissionModel? getPermissionByKey(String key) {
    for (final permission in _permissions) {
      if (permission.key == key) {
        return permission;
      }
    }

    return null;
  }

  void setPermissionEnabled(
    String permissionId,
    bool enabled,
  ) {
    final index = _permissions.indexWhere(
      (permission) => permission.id == permissionId,
    );

    if (index == -1) {
      return;
    }

    _permissions[index] = _permissions[index].copyWith(
      isEnabled: enabled,
      updatedAt: DateTime.now(),
    );

    _emitFiltered();
  }

  void updatePermission(
    AdminPermissionModel updatedPermission,
  ) {
    final index = _permissions.indexWhere(
      (permission) => permission.id == updatedPermission.id,
    );

    if (index == -1) {
      return;
    }

    _permissions[index] = updatedPermission;
    _emitFiltered();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();

    try {
      await Future<void>.delayed(
        const Duration(milliseconds: 150),
      );

      _permissions = AdminSettingsMockData.getPermissions();

      _emitFiltered();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void _emitFiltered() {
    state = AsyncValue.data(
      List<AdminPermissionModel>.from(filteredPermissions),
    );
  }
}