import 'package:flutter/material.dart';

import '../models/document_template.dart';
import 'document_editor_screen.dart';
import 'package:lawlink360/core/services/pdf_service.dart';

class DocumentPreviewScreen extends StatefulWidget {
  final DocumentTemplate template;

  const DocumentPreviewScreen({super.key, required this.template});

  @override
  State<DocumentPreviewScreen> createState() => _DocumentPreviewScreenState();
}

class _DocumentPreviewScreenState extends State<DocumentPreviewScreen> {
  late String documentBody;

  @override
  void initState() {
    super.initState();
    documentBody = widget.template.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F172A),
        title: const Text("Document Preview"),
      ),

      body: Column(
        children: [
          /// Document Preview
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.05),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.template.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 24),

                    Text(
                      documentBody,
                      style: const TextStyle(fontSize: 16, height: 1.8),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// Bottom Buttons
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  /// Edit Button
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final editedDocument = await Navigator.push<String>(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                DocumentEditorScreen(template: widget.template),
                          ),
                        );

                        if (editedDocument != null) {
                          setState(() {
                            documentBody = editedDocument;
                          });
                        }
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text("Edit Manually"),
                    ),
                  ),

                  const SizedBox(width: 12),

                  /// Download Button
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(24),
                            ),
                          ),
                          builder: (context) {
                            return Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "Download Document",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  ListTile(
                                    leading: const Icon(
                                      Icons.picture_as_pdf,
                                      color: Colors.red,
                                    ),
                                    title: const Text("Download as PDF"),
                                    onTap: () {
                                      Navigator.pop(context);

                                      // TODO:
                                      // Generate PDF here
                                    },
                                  ),

                                  ListTile(
                                    leading: const Icon(
                                      Icons.description,
                                      color: Colors.blue,
                                    ),
                                    title: const Text("Download as DOCX"),
                                    onTap: () async {
                                      Navigator.pop(context);

                                      await PdfService.previewPdf(
                                        title: widget.template.title,
                                        body: documentBody,
                                        rtl: false,
                                      );
                                    },
                                  ),

                                  const SizedBox(height: 10),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.download),
                      label: const Text("Download"),
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
