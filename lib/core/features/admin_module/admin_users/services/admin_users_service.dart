import 'package:lawlink360/core/features/admin_module/admin_users/data/mock/admin_users_mock_data.dart';
import 'package:lawlink360/core/features/admin_module/admin_users/models/admin_user_model.dart';

class AdminUsersService {
  const AdminUsersService();

  Future<List<AdminUserModel>> fetchUsers() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 500),
    );

    return List<AdminUserModel>.from(
      AdminUsersMockData.users,
    );
  }

  Future<List<AdminUserModel>> refreshUsers() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 300),
    );

    return List<AdminUserModel>.from(
      AdminUsersMockData.users,
    );
  }

  Future<AdminUserModel?> getUserById(String userId) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 200),
    );

    for (final user in AdminUsersMockData.users) {
      if (user.id == userId) {
        return user;
      }
    }

    return null;
  }
}