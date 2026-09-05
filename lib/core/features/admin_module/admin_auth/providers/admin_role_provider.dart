
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/admin_module/admin_auth/data/mock/admin_auth_mock_data.dart';
import 'package:lawlink360/core/features/admin_module/admin_auth/models/admin_role_model.dart';

final adminRoleProvider =
    NotifierProvider<AdminRoleNotifier, AsyncValue<List<AdminRoleModel>>>(
  AdminRoleNotifier.new,
);

class AdminRoleNotifier
    extends Notifier<AsyncValue<List<AdminRoleModel>>> {
  final List<AdminRoleModel> _roles = [];

  String _searchQuery = '';

  @override
  AsyncValue<List<AdminRoleModel>> build() {
    _roles
      ..clear()
      ..addAll(AdminAuthMockData.getRoles());

    return AsyncValue.data(_applyFilters());
  }

  List<AdminRoleModel> get roles =>
      List.unmodifiable(_roles);

  List<AdminRoleModel> get filteredRoles =>
      _applyFilters();

  String get searchQuery => _searchQuery;

  int get totalRoles => _roles.length;

  int get activeRoles =>
      _roles.where((role) => role.isActive).length;

  int get inactiveRoles =>
      _roles.where((role) => !role.isActive).length;

  List<AdminRoleModel> _applyFilters() {
    var result = List<AdminRoleModel>.from(_roles);

    if (_searchQuery.trim().isNotEmpty) {
      final query = _searchQuery.trim().toLowerCase();

      result = result.where((role) {
        return role.name.toLowerCase().contains(query) ||
            role.description.toLowerCase().contains(query) ||
            role.permissions.any(
              (permission) =>
                  permission.toLowerCase().contains(query),
            );
      }).toList();
    }

    result.sort(
      (a, b) => a.name.compareTo(b.name),
    );

    return result;
  }

  void _emitFiltered() {
    state = AsyncValue.data(
      _applyFilters(),
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();

    await Future<void>.delayed(
      const Duration(milliseconds: 300),
    );

    _roles
      ..clear()
      ..addAll(AdminAuthMockData.getRoles());

    _emitFiltered();
  }

  void search(String query) {
    _searchQuery = query;
    _emitFiltered();
  }

  void clearSearch() {
    _searchQuery = '';
    _emitFiltered();
  }

  AdminRoleModel? getRoleById(String id) {
    for (final role in _roles) {
      if (role.id == id) {
        return role;
      }
    }

    return null;
  }

  void addRole(AdminRoleModel role) {
    _roles.add(role);
    _emitFiltered();
  }

  void updateRole(AdminRoleModel updatedRole) {
    final index = _roles.indexWhere(
      (role) => role.id == updatedRole.id,
    );

    if (index == -1) {
      return;
    }

    _roles[index] = updatedRole.copyWith(
      updatedAt: DateTime.now(),
    );

    _emitFiltered();
  }

  void toggleRoleActive(String id) {
    final index = _roles.indexWhere(
      (role) => role.id == id,
    );

    if (index == -1) {
      return;
    }

    final current = _roles[index];

    _roles[index] = current.copyWith(
      isActive: !current.isActive,
      updatedAt: DateTime.now(),
    );

    _emitFiltered();
  }

  void deleteRole(String id) {
    _roles.removeWhere(
      (role) => role.id == id,
    );

    _emitFiltered();
  }
}
