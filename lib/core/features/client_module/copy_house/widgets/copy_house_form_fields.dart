import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

/// Shared form-field widgets used by more than one Copy House form.
///
/// Extracted from the District Court form to allow reuse without
/// duplicating widgets. Only truly generic widgets live here; case-
/// specific widgets (FIR row, party row, dynamic document list) stay
/// in the District Court form.
class CopyHouseTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final bool required;
  final int maxLength;
  final int maxLines;

  const CopyHouseTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.required = false,
    required this.maxLength,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: maxLength,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: required ? '$label *' : label,
        hintText: hint,
        alignLabelWithHint: maxLines > 1,
      ),
      validator: (value) {
        final text = (value ?? '').trim();
        if (required && text.isEmpty) return 'This field is required';
        if (text.length > maxLength) return 'Maximum $maxLength characters';
        return null;
      },
    );
  }
}

class CopyHouseDateField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final VoidCallback onTap;

  const CopyHouseDateField({
    super.key,
    required this.controller,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: const Icon(Icons.calendar_today_rounded),
      ),
    );
  }
}

/// A labelled dropdown form field.
///
/// `items` is a list of the values the form will store. `labels`
/// optionally provides human-readable text for each value; when null,
/// the value itself is shown. This exists because the Registered
/// Document Copies form stores stable subtype ids but shows friendly
/// labels.
class CopyHouseDropdownField extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final Map<String, String>? labels;
  final ValueChanged<String?> onChanged;
  final String? Function(String?) validator;

  const CopyHouseDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    this.labels,
    required this.onChanged,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(labelText: '$label *'),
      items: items
          .map(
            (i) => DropdownMenuItem<String>(
              value: i,
              child: Text(labels?[i] ?? i),
            ),
          )
          .toList(growable: false),
      onChanged: onChanged,
      validator: validator,
    );
  }
}

/// Two side-by-side party-name inputs separated by a visible `vs.`.
///
/// Stacks vertically on narrow screens so the layout does not overflow.
/// Both fields are required and validated as non-empty after trimming.
class CopyHousePartyRow extends StatelessWidget {
  final TextEditingController firstController;
  final TextEditingController secondController;
  final int maxPartyNameLength;

  const CopyHousePartyRow({
    super.key,
    required this.firstController,
    required this.secondController,
    this.maxPartyNameLength = 200,
  });

  @override
  Widget build(BuildContext context) {
    final vs = Text(
      'vs.',
      style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w700),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final narrow = constraints.maxWidth < 360;
        if (narrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: firstController,
                maxLength: maxPartyNameLength,
                decoration:
                    const InputDecoration(labelText: 'First Party'),
                validator: (v) => (v ?? '').trim().isEmpty
                    ? 'This field is required'
                    : null,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                child: Align(
                  alignment: Alignment.center,
                  child: vs,
                ),
              ),
              TextFormField(
                controller: secondController,
                maxLength: maxPartyNameLength,
                decoration:
                    const InputDecoration(labelText: 'Second Party'),
                validator: (v) => (v ?? '').trim().isEmpty
                    ? 'This field is required'
                    : null,
              ),
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                controller: firstController,
                maxLength: maxPartyNameLength,
                decoration:
                    const InputDecoration(labelText: 'First Party'),
                validator: (v) => (v ?? '').trim().isEmpty
                    ? 'This field is required'
                    : null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.md,
              ),
              child: vs,
            ),
            Expanded(
              child: TextFormField(
                controller: secondController,
                maxLength: maxPartyNameLength,
                decoration:
                    const InputDecoration(labelText: 'Second Party'),
                validator: (v) => (v ?? '').trim().isEmpty
                    ? 'This field is required'
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}