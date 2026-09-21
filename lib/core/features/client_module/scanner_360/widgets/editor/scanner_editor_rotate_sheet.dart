import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';

/// Bottom sheet for a fine-angle rotation.
///
/// The chosen angle is returned through [onApply] and the sheet is
/// then closed by the caller. Writing the rotated file is done by
/// the editor screen.
class ScannerEditorRotateSheet extends StatefulWidget {
  const ScannerEditorRotateSheet({
    super.key,
    required this.onApply,
  });

  final ValueChanged<double> onApply;

  @override
  State<ScannerEditorRotateSheet> createState() =>
      _ScannerEditorRotateSheetState();
}

class _ScannerEditorRotateSheetState
    extends State<ScannerEditorRotateSheet> {
  double _angle = 0.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rotate',
              style: AppTextStyles.title,
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Angle', style: AppTextStyles.body),
                Text(
                  '${_angle.toStringAsFixed(0)}°',
                  style: AppTextStyles.caption,
                ),
              ],
            ),
            Slider(
              value: _angle,
              min: 0.0,
              max: 360.0,
              divisions: 72,
              activeColor: AppColors.primary,
              onChanged: (v) => setState(() => _angle = v),
            ),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              width: double.infinity,
              height: AppSpacing.buttonHeight,
              child: ElevatedButton(
                onPressed: () {
                  widget.onApply(_angle);
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                ),
                child: const Text('Apply'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}