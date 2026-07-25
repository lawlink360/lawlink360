import 'package:local_auth/local_auth.dart';
import 'package:flutter/foundation.dart';

class BiometricService {
  final LocalAuthentication _auth = LocalAuthentication();

  /// Check if biometric authentication is available
  Future<bool> isBiometricAvailable() async {
    try {
      final bool canCheck = await _auth.canCheckBiometrics;
      final bool supported = await _auth.isDeviceSupported();

      return canCheck && supported;
    } catch (e) {
  debugPrint("Biometric Error: $e");
  return false;
}
  }

  /// Get available biometric types
  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } catch (_) {
      return [];
    }
  }

  /// Authenticate user
  Future<bool> authenticate() async {
    try {
      return await _auth.authenticate(
        localizedReason: 'Authenticate to access LawLink360',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
    } catch (_) {
      return false;
    }
  }
}