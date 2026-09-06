import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

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
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: TextFormField(
            keyboardType: field.keyboardType,
            maxLines: field.maxLines,
            style: AppTextStyles.body.copyWith(
              color: AppColors.textPrimary,
            ),
            decoration: InputDecoration(
              labelText: field.label,
              labelStyle: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
              floatingLabelStyle: AppTextStyles.bodySmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
              filled: true,
              fillColor: AppColors.surface,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.md,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
                borderSide: const BorderSide(
                  color: AppColors.border,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
                borderSide: const BorderSide(
                  color: AppColors.border,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 1.5,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
