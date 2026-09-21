import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_spacing.dart';
import 'scanner_editor_action_button.dart';

/// Toolbar for the editor screen.
///
/// Pure presentation. All actions are callbacks owned by the
/// editor screen.
class ScannerEditorToolbar extends StatelessWidget {
  const ScannerEditorToolbar({
    super.key,
    required this.onCrop,
    required this.onRotateLeft,
    required this.onRotateRight,
    required this.onOpenAngleSheet,
    required this.onOpenFilterSheet,
    required this.onOpenAdjustmentSheet,
    required this.onUndo,
    required this.onRedo,
    required this.onRetake,
    required this.onSave,
    required this.canUndo,
    required this.canRedo,
  });

  final VoidCallback onCrop;
  final VoidCallback onRotateLeft;
  final VoidCallback onRotateRight;
  final VoidCallback onOpenAngleSheet;
  final VoidCallback onOpenFilterSheet;
  final VoidCallback onOpenAdjustmentSheet;
  final VoidCallback onUndo;
  final VoidCallback onRedo;
  final VoidCallback onRetake;
  final VoidCallback onSave;
  final bool canUndo;
  final bool canRedo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: const BoxDecoration(
        color: AppColors.lightSurface,
        border: Border(
          top: BorderSide(color: AppColors.lightBorder),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ScannerEditorActionButton(
                    icon: Icons.crop,
                    label: 'Crop',
                    onTap: onCrop,
                  ),
                  ScannerEditorActionButton(
                    icon: Icons.rotate_90_degrees_ccw,
                    label: 'Rotate L',
                    onTap: onRotateLeft,
                  ),
                  ScannerEditorActionButton(
                    icon: Icons.rotate_90_degrees_cw,
                    label: 'Rotate R',
                    onTap: onRotateRight,
                  ),
                  ScannerEditorActionButton(
                    icon: Icons.rotate_right,
                    label: 'Angle',
                    onTap: onOpenAngleSheet,
                  ),
                  ScannerEditorActionButton(
                    icon: Icons.filter_vintage_outlined,
                    label: 'Filter',
                    onTap: onOpenFilterSheet,
                  ),
                  ScannerEditorActionButton(
                    icon: Icons.tune,
                    label: 'Adjust',
                    onTap: onOpenAdjustmentSheet,
                  ),
                  ScannerEditorActionButton(
                    icon: Icons.undo,
                    label: 'Undo',
                    onTap: onUndo,
                    enabled: canUndo,
                  ),
                  ScannerEditorActionButton(
                    icon: Icons.redo,
                    label: 'Redo',
                    onTap: onRedo,
                    enabled: canRedo,
                  ),
                  ScannerEditorActionButton(
                    icon: Icons.refresh,
                    label: 'Retake',
                    onTap: onRetake,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          SizedBox(
            width: 76,
            height: AppSpacing.buttonHeight,
            child: ElevatedButton(
              onPressed: onSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: AppColors.primary,
                minimumSize: const Size(76, AppSpacing.buttonHeight),
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
              ),
              child: const Text('Save'),
            ),
          ),
        ],
      ),
    );
  }
}