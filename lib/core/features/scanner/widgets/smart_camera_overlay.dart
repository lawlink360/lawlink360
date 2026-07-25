import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'smart_camera_preview.dart';

class SmartCameraOverlay extends StatelessWidget {
  final CameraController controller;

  const SmartCameraOverlay({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return IgnorePointer(
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Positioned(
            top: 5,
            child: Text(
              "Place document inside frame",
              style: TextStyle(
                color: Color(0xFFD4AF37),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Positioned(
            top: 40,
            child: SizedBox(
              width: screenWidth * 0.92,
              height: screenWidth * 1.35,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: SmartCameraPreview(
                      controller: controller,
                    ),
                  ),

                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFFD4AF37),
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}