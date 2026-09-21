import 'package:permission_handler/permission_handler.dart';

/// Result of a single permission request.
enum ScannerPermissionResult {
  granted,
  denied,
  permanentlyDenied,
  restricted,
}

/// Handles OS permission requests required by Scanner 360.
///
/// Only camera and photo-library permissions are in scope.
/// File-system storage for app-private directories does not require
/// runtime permission on Android.
class ScannerPermissionService {
  const ScannerPermissionService();

  // ============================================================
  // Camera
  // ============================================================

  Future<ScannerPermissionResult> requestCamera() async {
    final status = await Permission.camera.request();
    return _map(status);
  }

  Future<ScannerPermissionResult> checkCamera() async {
    final status = await Permission.camera.status;
    return _map(status);
  }

  // ============================================================
  // Photos / gallery
  // ============================================================

  Future<ScannerPermissionResult> requestPhotos() async {
    final status = await Permission.photos.request();
    return _map(status);
  }

  Future<ScannerPermissionResult> checkPhotos() async {
    final status = await Permission.photos.status;
    return _map(status);
  }

  // ============================================================
  // Combined camera + photos request
  // ============================================================

  /// Requests camera and photos in a single pass.
  ///
  /// Returns a record with both results.
  Future<({ScannerPermissionResult camera, ScannerPermissionResult photos})>
      requestCameraAndPhotos() async {
    final results = await [Permission.camera, Permission.photos].request();
    return (
      camera: _map(results[Permission.camera] ?? PermissionStatus.denied),
      photos: _map(results[Permission.photos] ?? PermissionStatus.denied),
    );
  }

  // ============================================================
  // Mapping
  // ============================================================

  ScannerPermissionResult _map(PermissionStatus status) {
    if (status.isGranted || status.isLimited) {
      return ScannerPermissionResult.granted;
    }
    if (status.isPermanentlyDenied) {
      return ScannerPermissionResult.permanentlyDenied;
    }
    if (status.isRestricted) {
      return ScannerPermissionResult.restricted;
    }
    return ScannerPermissionResult.denied;
  }
}