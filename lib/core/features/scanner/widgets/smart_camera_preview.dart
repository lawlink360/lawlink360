import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class SmartCameraPreview extends StatelessWidget {
  final CameraController controller;

  const SmartCameraPreview({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFFD4AF37),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: controller.value.previewSize!.height,
          height: controller.value.previewSize!.width,
          child: CameraPreview(controller),
        ),
      ),
    );
  }
}