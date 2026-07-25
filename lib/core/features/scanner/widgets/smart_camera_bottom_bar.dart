import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'smart_capture_button.dart';

class SmartCameraBottomBar extends StatelessWidget {
  final VoidCallback? onCapture;

  const SmartCameraBottomBar({
    super.key,
    this.onCapture,
  });

  Future<void> _openGallery(BuildContext context) async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Image Selected:\n${image.name}"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => _openGallery(context),
                icon: const Icon(
                  Icons.photo_library_outlined,
                  color: Colors.white,
                  size: 32,
                ),
              ),

              SmartCaptureButton(
                onPressed: onCapture,
              ),

              PopupMenuButton<String>(
                icon: const Icon(
                  Icons.flash_auto,
                  color: Colors.white,
                  size: 32,
                ),
                onSelected: (value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Flash Mode: $value"),
                    ),
                  );
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: "Auto",
                    child: Text("Auto"),
                  ),
                  PopupMenuItem(
                    value: "On",
                    child: Text("On"),
                  ),
                  PopupMenuItem(
                    value: "Off",
                    child: Text("Off"),
                  ),
                  PopupMenuItem(
                    value: "Torch",
                    child: Text("Torch"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}