import 'dart:io';
import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';

import 'document_editor_screen.dart';

class DocumentCropScreen extends StatefulWidget {
  final String imagePath;

  const DocumentCropScreen({super.key, required this.imagePath});

  @override
  State<DocumentCropScreen> createState() => _DocumentCropScreenState();
}

class _DocumentCropScreenState extends State<DocumentCropScreen> {
  final CropController _cropController = CropController();

  late final Uint8List _imageData;

  bool _isCropping = false;

  @override
  void initState() {
    super.initState();

    _imageData = File(widget.imagePath).readAsBytesSync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Crop Document"),
      ),
      body: Crop(
        controller: _cropController,
        image: _imageData,
        baseColor: Colors.black,
        maskColor: Colors.black.withValues(alpha: 0.55),
        cornerDotBuilder: (_, _) {
          return Container(
            width: 22,
            height: 22,
            decoration: const BoxDecoration(
              color: Color(0xFFD4AF37),
              shape: BoxShape.circle,
            ),
          );
        },
        onCropped: (result) async {
          final navigator = Navigator.of(context);
          final messenger = ScaffoldMessenger.of(context);

          switch (result) {
            case CropSuccess():
              final file = File(widget.imagePath);

              await file.writeAsBytes(result.croppedImage);

              if (!mounted) return;

              navigator.pushReplacement(
                MaterialPageRoute(
                  builder: (_) => DocumentEditorScreen(imagePath: file.path),
                ),
              );

              break;

            case CropFailure():
              if (!mounted) return;

              messenger.showSnackBar(
                SnackBar(content: Text(result.cause.toString())),
              );

              break;
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: 55,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD4AF37),
              foregroundColor: Colors.black,
            ),
            onPressed: _isCropping
                ? null
                : () {
                    setState(() {
                      _isCropping = true;
                    });

                    _cropController.crop();
                  },
            child: const Text(
              "Apply Crop",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
