import 'package:flutter/material.dart';

import '../../models/document_template.dart';

import 'application_template_card.dart';
import '../../screens/document_preview_screen.dart';

class ApplicationTemplateGrid extends StatelessWidget {
  final List<DocumentTemplate> templates;

  const ApplicationTemplateGrid({super.key, required this.templates});

  @override
  Widget build(BuildContext context) {
    if (templates.isEmpty) {
      return const Center(
        child: Text(
          'No templates available',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 30),
      itemCount: templates.length,
      itemBuilder: (context, index) {
        final template = templates[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: ApplicationTemplateCard(
            template: template,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DocumentPreviewScreen(template: template),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
