import 'package:flutter/material.dart';

import '../../models/form_field_model.dart';

class DynamicGuidedForm extends StatelessWidget {
  final List<FormFieldModel> fields;

  const DynamicGuidedForm({
    super.key,
    required this.fields,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: fields.map((field) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: TextFormField(
            keyboardType: field.keyboardType,
            maxLines: field.maxLines,
            decoration: InputDecoration(
              labelText: field.label,
              border: const OutlineInputBorder(),
            ),
          ),
        );
      }).toList(),
    );
  }
}