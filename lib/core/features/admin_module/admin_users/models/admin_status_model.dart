import 'admin_user_model.dart';

class AdminUserStateModel {
  final bool isLoading;
  final bool isRefreshing;
  final List<AdminUserModel> users;
  final String searchQuery;
  final String? selectedStatus;
  final String? errorMessage;

  const AdminUserStateModel({
    this.isLoading = false,
    this.isRefreshing = false,
    this.users = const [],
    this.searchQuery = '',
    this.selectedStatus,
    this.errorMessage,
  });

  List<AdminUserModel> get filteredUsers {
    final query = searchQuery.trim().toLowerCase();

    return users.where((user) {
      final matchesSearch = query.isEmpty ||
          user.name.toLowerCase().contains(query) ||
          user.email.toLowerCase().contains(query) ||
          user.phone.toLowerCase().contains(query);

      final matchesStatus =
          selectedStatus == null ||
          selectedStatus!.isEmpty ||
          user.status.toLowerCase() ==
              selectedStatus!.toLowerCase();

      return matchesSearch && matchesStatus;
    }).toList();
  }

  int get totalUsers => users.length;

  int get activeUsers => users
      .where(
        (user) => user.status.toLowerCase() == 'active',
      )
      .length;

  int get suspendedUsers => users
      .where(
        (user) => user.status.toLowerCase() == 'suspended',
      )
      .length;

  int get verifiedUsers =>
      users.where((user) => user.isVerified).length;

  AdminUserStateModel copyWith({
    bool? isLoading,
    bool? isRefreshing,
    List<AdminUserModel>? users,
    String? searchQuery,
    String? selectedStatus,
    String? errorMessage,
    bool clearStatus = false,
    bool clearError = false,
  }) {
    return AdminUserStateModel(
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      users: users ?? this.users,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedStatus:
          clearStatus ? null : selectedStatus ?? this.selectedStatus,
      errorMessage:
          clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  AdminUserStateModel clearError() {
    return AdminUserStateModel(
      isLoading: isLoading,
      isRefreshing: isRefreshing,
      users: users,
      searchQuery: searchQuery,
      selectedStatus: selectedStatus,
      errorMessage: null,
    );
  }
}