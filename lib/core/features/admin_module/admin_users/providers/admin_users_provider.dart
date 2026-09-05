import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/admin_module/admin_users/models/admin_user_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_users/services/admin_users_service.dart';

final adminUsersServiceProvider = Provider<AdminUsersService>((ref) {
  return const AdminUsersService();
});

final adminUsersProvider =
    NotifierProvider<AdminUsersNotifier, List<AdminUserModel>>(
  AdminUsersNotifier.new,
);

class AdminUsersNotifier extends Notifier<List<AdminUserModel>> {
  late final AdminUsersService _service;

  String _searchQuery = '';
  String? _selectedStatus;

  bool _isLoading = false;
  bool _isRefreshing = false;
  Object? _error;

  @override
  List<AdminUserModel> build() {
    _service = ref.watch(adminUsersServiceProvider);

    return const [];
  }

  String get searchQuery => _searchQuery;

  String? get selectedStatus => _selectedStatus;

  bool get isLoading => _isLoading;

  bool get isRefreshing => _isRefreshing;

  Object? get error => _error;

  bool get hasError => _error != null;

  List<AdminUserModel> get filteredUsers {
    final query = _searchQuery.trim().toLowerCase();

    return state.where((user) {
      final matchesSearch = query.isEmpty ||
          user.name.toLowerCase().contains(query) ||
          user.email.toLowerCase().contains(query) ||
          user.phone.toLowerCase().contains(query);

      final matchesStatus = _selectedStatus == null ||
          _selectedStatus!.isEmpty ||
          user.status.toLowerCase() ==
              _selectedStatus!.toLowerCase();

      return matchesSearch && matchesStatus;
    }).toList();
  }

  int get totalUsers => state.length;

  int get activeUsers => state
      .where(
        (user) => user.status.toLowerCase() == 'active',
      )
      .length;

  int get inactiveUsers => state
      .where(
        (user) => user.status.toLowerCase() == 'inactive',
      )
      .length;

  int get suspendedUsers => state
      .where(
        (user) => user.status.toLowerCase() == 'suspended',
      )
      .length;

  int get verifiedUsers =>
      state.where((user) => user.isVerified).length;

  Future<void> loadUsers() async {
    _setLoading(true);
    _clearError();

    try {
      final users = await _service.fetchUsers();

      state = users;
    } catch (error) {
      _error = error;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> refreshUsers() async {
    if (_isRefreshing) {
      return;
    }

    _isRefreshing = true;
    _clearError();

    try {
      final users = await _service.refreshUsers();

      state = users;
    } catch (error) {
      _error = error;
    } finally {
      _isRefreshing = false;
    }
  }

  void searchUsers(String query) {
    _searchQuery = query;
  }

  void filterByStatus(String? status) {
    if (status == null || status.isEmpty) {
      _selectedStatus = null;
      return;
    }

    _selectedStatus = status;
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedStatus = null;
  }

  Future<void> updateUserStatus(
    String userId,
    String newStatus,
  ) async {
    state = state.map((user) {
      if (user.id == userId) {
        return user.copyWith(
          status: newStatus,
        );
      }

      return user;
    }).toList();
  }

  Future<AdminUserModel?> getUserById(
    String userId,
  ) async {
    final user = await _service.getUserById(userId);

    if (user != null) {
      return user;
    }

    for (final item in state) {
      if (item.id == userId) {
        return item;
      }
    }

    return null;
  }

  void clearError() {
    _clearError();
  }

  void _setLoading(bool value) {
    _isLoading = value;
  }

  void _clearError() {
    _error = null;
  }
}