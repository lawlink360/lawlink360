import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/scanner_camera_service.dart';
import '../services/scanner_permission_service.dart';

/// Immutable state exposed by [ScannerCameraNotifier].
class ScannerCameraState {
  const ScannerCameraState({
    this.isInitialized = false,
    this.isCapturing = false,
    this.flashMode = FlashMode.auto,
    this.activeLensDirection,
    this.error,
  });

  final bool isInitialized;
  final bool isCapturing;
  final FlashMode flashMode;
  final CameraLensDirection? activeLensDirection;
  final String? error;

  ScannerCameraState copyWith({
    bool? isInitialized,
    bool? isCapturing,
    FlashMode? flashMode,
    CameraLensDirection? activeLensDirection,
    String? error,
    bool clearError = false,
    bool clearActiveLens = false,
  }) {
    return ScannerCameraState(
      isInitialized: isInitialized ?? this.isInitialized,
      isCapturing: isCapturing ?? this.isCapturing,
      flashMode: flashMode ?? this.flashMode,
      activeLensDirection: clearActiveLens
          ? null
          : (activeLensDirection ?? this.activeLensDirection),
      error: clearError ? null : (error ?? this.error),
    );
  }
}

/// Manages the camera lifecycle for Scanner 360.
class ScannerCameraNotifier extends Notifier<ScannerCameraState> {
  final ScannerCameraService _service = ScannerCameraService();
  final ScannerPermissionService _permissions =
      const ScannerPermissionService();

  /// Read-only access to the underlying [CameraController].
  ///
  /// The controller is a runtime resource, not UI state, so it is
  /// not stored in [ScannerCameraState]. It is exposed here only
  /// for rendering [CameraPreview].
  CameraController? get controller => _service.controller;

  @override
  ScannerCameraState build() {
    ref.onDispose(() {
      _service.dispose();
    });
    return const ScannerCameraState();
  }

  /// Requests permission and initializes the camera.
  Future<void> initialize() async {
    final result = await _permissions.requestCamera();
    if (result != ScannerPermissionResult.granted) {
      state = state.copyWith(
        isInitialized: false,
        error: 'Camera permission was not granted.',
      );
      return;
    }

    try {
      await _service.initialize();
      state = state.copyWith(
        isInitialized: true,
        flashMode: _service.flashMode,
        activeLensDirection: _service.activeCamera?.lensDirection,
        clearError: true,
      );
    } catch (e) {
      state = state.copyWith(
        isInitialized: false,
        error: e.toString(),
      );
    }
  }

  /// Captures a still image and returns its file path, or null on
  /// failure. Errors are stored in state.
  Future<String?> capture() async {
    if (!_service.isInitialized) {
      state = state.copyWith(error: 'Camera is not initialized.');
      return null;
    }

    state = state.copyWith(isCapturing: true, clearError: true);

    try {
      final path = await _service.captureToFile();
      state = state.copyWith(isCapturing: false);
      return path;
    } catch (e) {
      state = state.copyWith(
        isCapturing: false,
        error: e.toString(),
      );
      return null;
    }
  }

  /// Cycles the flash mode and updates state.
  Future<void> cycleFlash() async {
    await _service.cycleFlash();
    state = state.copyWith(flashMode: _service.flashMode);
  }

  /// Switches to the next available camera.
  Future<void> switchCamera() async {
    try {
      await _service.switchCamera();
      state = state.copyWith(
        activeLensDirection: _service.activeCamera?.lensDirection,
        clearError: true,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Picks an image from the gallery. Returns its path or null.
  Future<String?> pickFromGallery() async {
    try {
      final path = await _service.pickFromGallery();
      return path;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return null;
    }
  }

  /// Releases camera resources.
  Future<void> disposeCamera() async {
    await _service.dispose();
    state = const ScannerCameraState();
  }

  /// Clears the current error message.
  void clearError() {
    state = state.copyWith(clearError: true);
  }
}

final scannerCameraProvider =
    NotifierProvider<ScannerCameraNotifier, ScannerCameraState>(
  ScannerCameraNotifier.new,
);