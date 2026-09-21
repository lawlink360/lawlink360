import 'dart:io';

import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../constants/scanner_constants.dart';

/// Raised when the camera cannot be initialized or used.
class ScannerCameraException implements Exception {
  const ScannerCameraException(this.message);
  final String message;

  @override
  String toString() => 'ScannerCameraException: $message';
}

/// Wraps the `camera` package for Scanner 360.
///
/// No UI. No image processing. No `ScannerMode` dependency.
class ScannerCameraService {
  ScannerCameraService();

  CameraController? _controller;
  List<CameraDescription> _cameras = const [];
  CameraDescription? _activeCamera;
  FlashMode _flashMode = FlashMode.auto;

  // ============================================================
  // Accessors
  // ============================================================

  bool get isInitialized =>
      _controller != null && _controller!.value.isInitialized;

  CameraController? get controller => _controller;

  List<CameraDescription> get cameras => List.unmodifiable(_cameras);

  CameraDescription? get activeCamera => _activeCamera;

  FlashMode get flashMode => _flashMode;

  // ============================================================
  // Initialization
  // ============================================================

  /// Loads the list of available cameras and prepares the rear one.
  Future<void> initialize({
    ResolutionPreset resolution = ResolutionPreset.high,
    bool enableAudio = false,
  }) async {
    _cameras = await availableCameras();
    if (_cameras.isEmpty) {
      throw const ScannerCameraException('No cameras available.');
    }

    final rear = _cameras.firstWhere(
      (c) => c.lensDirection == CameraLensDirection.back,
      orElse: () => _cameras.first,
    );

    await _initController(rear, resolution, enableAudio);
  }

  Future<void> _initController(
    CameraDescription camera,
    ResolutionPreset resolution,
    bool enableAudio,
  ) async {
    await _controller?.dispose();

    final controller = CameraController(
      camera,
      resolution,
      enableAudio: enableAudio,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    try {
      await controller.initialize();
    } catch (e) {
      await controller.dispose();
      throw ScannerCameraException(e.toString());
    }

    await controller.setFlashMode(_flashMode);

    _controller = controller;
    _activeCamera = camera;
  }

  // ============================================================
  // Preview lifecycle
  // ============================================================

  Future<void> startPreview() async {
    final c = _controller;
    if (c == null || !c.value.isInitialized) {
      throw const ScannerCameraException('Camera is not initialized.');
    }
    await c.resumePreview();
  }

  Future<void> stopPreview() async {
    final c = _controller;
    if (c == null || !c.value.isInitialized) return;
    await c.pausePreview();
  }

  // ============================================================
  // Capture
  // ============================================================

  /// Captures a still image and copies it to the app-private temp
  /// directory with a stable extension. Returns the copied file path.
  Future<String> captureToFile() async {
    final c = _controller;
    if (c == null || !c.value.isInitialized) {
      throw const ScannerCameraException('Camera is not initialized.');
    }

    final XFile shot = await c.takePicture();

    final temp = await getTemporaryDirectory();
    final fileName =
        'scan_${DateTime.now().microsecondsSinceEpoch}${ScannerConstants.jpgExtension}';
    final target = File(
      '${temp.path}${Platform.pathSeparator}$fileName',
    );

    await File(shot.path).copy(target.path);
    return target.path;
  }

  // ============================================================
  // Flash
  // ============================================================

  Future<void> setFlashMode(FlashMode mode) async {
    _flashMode = mode;
    final c = _controller;
    if (c != null && c.value.isInitialized) {
      await c.setFlashMode(mode);
    }
  }

  Future<void> cycleFlash() async {
    switch (_flashMode) {
      case FlashMode.off:
        await setFlashMode(FlashMode.auto);
        break;
      case FlashMode.auto:
        await setFlashMode(FlashMode.always);
        break;
      case FlashMode.always:
        await setFlashMode(FlashMode.off);
        break;
      case FlashMode.torch:
        await setFlashMode(FlashMode.off);
        break;
    }
  }

  // ============================================================
  // Camera switching
  // ============================================================

  Future<void> switchCamera() async {
    if (_cameras.length < 2) return;

    final current = _activeCamera;
    final next = _cameras.firstWhere(
      (c) => c != current,
      orElse: () => _cameras.first,
    );

    final resolution = _controller?.resolutionPreset ??
        ResolutionPreset.high;

    await _initController(next, resolution, false);
  }

  // ============================================================
  // Gallery import
  // ============================================================

  /// Picks a single image from the gallery and returns its path.
  Future<String?> pickFromGallery() async {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: ScannerConstants.cameraJpegQuality,
    );
    return picked?.path;
  }

  // ============================================================
  // Dispose
  // ============================================================

  Future<void> dispose() async {
    await _controller?.dispose();
    _controller = null;
    _activeCamera = null;
  }
}