import 'dart:io';

import 'package:flutter/material.dart';
import 'document_crop_screen.dart';

class DocumentEditorScreen extends StatefulWidget {
  final String imagePath;

  const DocumentEditorScreen({super.key, required this.imagePath});

  @override
  State<DocumentEditorScreen> createState() => _DocumentEditorScreenState();
}

class _DocumentEditorScreenState extends State<DocumentEditorScreen> {
  int selectedFilter = 0;

  final filters = ["Original", "B&W", "Magic"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Edit Document"),
      ),

      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.file(File(widget.imagePath), fit: BoxFit.contain),
              ),
            ),
          ),

          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final selected = selectedFilter == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedFilter = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selected
                            ? const Color(0xFFD4AF37)
                            : Colors.white24,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        filters[index],
                        style: TextStyle(
                          color: selected
                              ? const Color(0xFFD4AF37)
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          DocumentCropScreen(imagePath: widget.imagePath),
                    ),
                  );
                },
                child: const Text("Save"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
