import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/admin_model.dart';

/// Provides the currently authenticated administrator.
///
/// This is intentionally kept as an in-memory provider for the UI phase.
/// Firebase authentication and persistent admin data will be connected
/// during the backend phase.
final currentAdminProvider = StateProvider<AdminModel?>((ref) {
  return null;
});

/// Provides whether the Admin Module is currently in a loading state.
final adminLoadingProvider = StateProvider<bool>((ref) {
  return false;
});

/// Provides the current Admin error message, if any.
final adminErrorProvider = StateProvider<String?>((ref) {
  return null;
});