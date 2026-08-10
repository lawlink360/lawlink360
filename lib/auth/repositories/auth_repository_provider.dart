import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/auth_service_provider.dart';
import 'auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    ref.read(authServiceProvider),
  );
});