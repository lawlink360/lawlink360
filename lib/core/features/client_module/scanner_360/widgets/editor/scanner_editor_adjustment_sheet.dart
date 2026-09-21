import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';

/// Bottom sheet with sliders for brightness, contrast, saturation
/// and gamma.
///
/// Values are reported through [onChanged]. They are not written to
/// a file here; the editor screen holds them as pending edits until
/// Save is tapped.
class ScannerEditorAdjustmentSheet extends StatefulWidget {
  const ScannerEditorAdjustmentSheet({
    super.key,
    required this.initialBrightness,
    required this.initialContrast,
    required this.initialSaturation,
    required this.initialGamma,
    required this.onChanged,
  });

  final double initialBrightness;
  final double initialContrast;
  final double initialSaturation;
  final double initialGamma;
  final void Function({
    required double brightness,
    required double contrast,
    required double saturation,
    required double gamma,
  }) onChanged;

  @override
  State<ScannerEditorAdjustmentSheet> createState() =>
      _ScannerEditorAdjustmentSheetState();
}

class _ScannerEditorAdjustmentSheetState
    extends State<ScannerEditorAdjustmentSheet> {
  late double _brightness;
  late double _contrast;
  late double _saturation;
  late double _gamma;

  @override
  void initState() {
    super.initState();
    _brightness = widget.initialBrightness;
    _contrast = widget.initialContrast;
    _saturation = widget.initialSaturation;
    _gamma = widget.initialGamma;
  }

  void _emit() {
    widget.onChanged(
      brightness: _brightness,
      contrast: _contrast,
      saturation: _saturation,
      gamma: _gamma,
    );
  }

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
              'Adjust',
              style: AppTextStyles.title,
            ),
            const SizedBox(height: AppSpacing.md),
            _AdjustSlider(
              label: 'Brightness',
              value: _brightness,
              min: 0.5,
              max: 1.5,
              onChanged: (v) {
                setState(() => _brightness = v);
                _emit();
              },
            ),
            _AdjustSlider(
              label: 'Contrast',
              value: _contrast,
              min: 0.5,
              max: 1.5,
              onChanged: (v) {
                setState(() => _contrast = v);
                _emit();
              },
            ),
            _AdjustSlider(
              label: 'Saturation',
              value: _saturation,
              min: 0.0,
              max: 2.0,
              onChanged: (v) {
                setState(() => _saturation = v);
                _emit();
              },
            ),
            _AdjustSlider(
              label: 'Gamma',
              value: _gamma,
              min: 0.5,
              max: 2.0,
              onChanged: (v) {
                setState(() => _gamma = v);
                _emit();
              },
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }
}

class _AdjustSlider extends StatelessWidget {
  const _AdjustSlider({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTextStyles.body),
            Text(
              value.toStringAsFixed(2),
              style: AppTextStyles.caption,
            ),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          activeColor: AppColors.primary,
          onChanged: onChanged,
        ),
      ],
    );
  }
}