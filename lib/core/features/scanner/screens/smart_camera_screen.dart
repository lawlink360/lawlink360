import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'package:lawlink360/core/features/scanner/models/scanner_mode.dart';

import '../services/camera_service.dart';
import '../widgets/smart_camera_overlay.dart';
import '../widgets/smart_camera_top_modes.dart';
import '../widgets/smart_camera_bottom_bar.dart';
import 'document_preview_screen.dart';

class SmartCameraScreen extends StatefulWidget {
  final ScannerMode initialMode;

  const SmartCameraScreen({super.key, required this.initialMode});

  @override
  State<SmartCameraScreen> createState() => _SmartCameraScreenState();
}

class _SmartCameraScreenState extends State<SmartCameraScreen> {
  CameraController? _controller;
  bool _cameraReady = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _capturePhoto() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      return;
    }

    try {
      final image = await _controller!.takePicture();

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DocumentPreviewScreen(imagePath: image.path),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Capture failed: $e")));
    }
  }

  Future<void> _initializeCamera() async {
    final cameras = CameraService.cameras;

    if (cameras == null || cameras.isEmpty) return;

    _controller = CameraController(
      cameras.first,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await _controller!.initialize();

    if (!mounted) return;

    setState(() {
      _cameraReady = true;
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  String getTitle() {
    switch (widget.initialMode) {
      case ScannerMode.document:
        return "Document Scanner";
      case ScannerMode.idCard:
        return "ID Card Scanner";
      case ScannerMode.book:
        return "Book Scanner";
      case ScannerMode.whiteboard:
        return "Whiteboard Scanner";
      case ScannerMode.ocr:
        return "OCR Scanner";
      case ScannerMode.translate:
        return "Translate Scanner";
      case ScannerMode.qrCode:
        return "QR Code Scanner";
      case ScannerMode.idPhotoMaker:
        return "ID Photo Maker";
      case ScannerMode.timeStamp:
        return "Time Stamp Camera";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text(
          getTitle(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: _cameraReady && _controller != null
                    ? SmartCameraOverlay(controller: _controller!)
                    : const CircularProgressIndicator(color: Color(0xFFD4AF37)),
              ),
            ),

            const SmartCameraTopModes(),

            const SizedBox(height: 8),

            SmartCameraBottomBar(onCapture: _capturePhoto),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
