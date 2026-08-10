import 'package:flutter/material.dart';

import '../models/document_template.dart';

class DocumentEditorScreen extends StatefulWidget {
  final DocumentTemplate template;

  const DocumentEditorScreen({super.key, required this.template});

  @override
  State<DocumentEditorScreen> createState() => _DocumentEditorScreenState();
}

class _DocumentEditorScreenState extends State<DocumentEditorScreen> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.template.body);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Document"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              Navigator.pop(context, controller.text);
            },
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: TextField(
          controller: controller,

          expands: true,

          maxLines: null,

          minLines: null,

          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
      ),
    );
  }
}
