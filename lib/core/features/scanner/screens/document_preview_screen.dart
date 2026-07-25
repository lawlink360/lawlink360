import 'dart:io';

import 'package:flutter/material.dart';
import 'document_editor_screen.dart';

class DocumentPreviewScreen extends StatelessWidget {
  final String imagePath;

  const DocumentPreviewScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Document Preview"),
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(
                    File(imagePath),
                    fit: BoxFit.contain,
                    width: double.infinity,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Retake"),
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                DocumentEditorScreen(imagePath: imagePath),
                          ),
                        );
                      },
                      child: const Text("Continue"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
