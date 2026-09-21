import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../models/pdf_tools/scanner_pdf_tool_config.dart';
import '../../models/pdf_tools/scanner_pdf_tool_field.dart';
import '../../widgets/pdf_tools/scanner_pdf_input_selector.dart';
import '../../widgets/shared/scanner_loading_overlay.dart';
import 'scanner_pdf_result_screen.dart';

/// Generic flow screen used by every PDF tool.
class ScannerPdfToolFlowScreen extends ConsumerStatefulWidget {
  const ScannerPdfToolFlowScreen({
    super.key,
    required this.config,
  });

  final ScannerPdfToolConfig config;

  @override
  ConsumerState<ScannerPdfToolFlowScreen> createState() =>
      _ScannerPdfToolFlowScreenState();
}

class _ScannerPdfToolFlowScreenState
    extends ConsumerState<ScannerPdfToolFlowScreen> {
  final ScannerPdfInputSelector _inputSelector =
      const ScannerPdfInputSelector();

  final List<String> _inputPaths = <String>[];
  final Map<String, Object?> _values = <String, Object?>{};
  String? _outputPath;
  String? _error;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    for (final field in widget.config.fields) {
      if (field.defaultValue != null) {
        _values[field.id] = field.defaultValue;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        title: Text(widget.config.title),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.config.subtitle,
                    style: AppTextStyles.bodySmall,
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  const _SectionHeader(title: 'Input PDF'),
                  const SizedBox(height: AppSpacing.sm),
                  ScannerPdfInputSummary(
                    paths: _inputPaths,
                    onPick: _handlePickInput,
                  ),

                  if (widget.config.fields.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.lg),
                    const _SectionHeader(title: 'Configuration'),
                    const SizedBox(height: AppSpacing.sm),
                    ...widget.config.fields.map(_buildField),
                  ],

                  const SizedBox(height: AppSpacing.lg),
                  const _SectionHeader(title: 'Output'),
                  const SizedBox(height: AppSpacing.sm),
                  _OutputSummary(
                    path: _outputPath,
                    onPick: _handlePickOutput,
                  ),

                  if (_error != null) ...[
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      _error!,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                  ],

                  const SizedBox(height: AppSpacing.xl),
                  SizedBox(
                    width: double.infinity,
                    height: AppSpacing.buttonHeight,
                    child: ElevatedButton(
                      onPressed: _isRunning ? null : _handleRun,
                      child: const Text('Run'),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ],
              ),
            ),
            if (_isRunning)
              const ScannerLoadingOverlay(label: 'Processing…'),
          ],
        ),
      ),
    );
  }

  Widget _buildField(ScannerPdfToolField field) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: _FieldInput(
        field: field,
        initialValue: _values[field.id],
        onChanged: (v) => setState(() => _values[field.id] = v),
      ),
    );
  }

  Future<void> _handlePickInput() async {
    final paths = await _inputSelector.pick(
      context: context,
      ref: ref,
      allowMultiple: widget.config.allowsMultipleInputs,
    );
    if (paths == null || paths.isEmpty) return;

    setState(() {
      _inputPaths.clear();
      if (widget.config.allowsMultipleInputs) {
        _inputPaths.addAll(paths);
      } else {
        _inputPaths.add(paths.first);
      }
      _error = null;
    });
  }

  Future<void> _handlePickOutput() async {
    final suggested = '${widget.config.id}_output.pdf';

    final path = await FilePicker.platform.saveFile(
      dialogTitle: 'Save output PDF',
      fileName: suggested,
      type: FileType.custom,
      allowedExtensions: const ['pdf'],
    );

    if (path == null || path.isEmpty) return;

    final resolved = path.toLowerCase().endsWith('.pdf')
        ? path
        : '$path.pdf';

    setState(() {
      _outputPath = resolved;
      _error = null;
    });
  }

  Future<void> _handleRun() async {
    if (_inputPaths.isEmpty) {
      setState(() => _error = 'Please select an input PDF.');
      return;
    }
    if (_outputPath == null || _outputPath!.isEmpty) {
      setState(() => _error = 'Please choose an output location.');
      return;
    }

    setState(() {
      _isRunning = true;
      _error = null;
    });

    try {
      final input = ScannerPdfToolRunInput(
        inputPaths: List<String>.from(_inputPaths),
        outputPath: _outputPath!,
        values: Map<String, Object?>.from(_values),
      );
      final outputs = await widget.config.run(input);

      if (!mounted) return;

      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ScannerPdfResultScreen(
            outputPaths: outputs,
            toolTitle: widget.config.title,
          ),
        ),
      );
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _isRunning = false);
    }
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.title,
    );
  }
}

class _OutputSummary extends StatelessWidget {
  const _OutputSummary({
    required this.path,
    required this.onPick,
  });

  final String? path;
  final VoidCallback onPick;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.lightBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            path ?? 'No output location selected.',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.caption,
          ),
          const SizedBox(height: AppSpacing.sm),
          OutlinedButton.icon(
            onPressed: onPick,
            icon: const Icon(Icons.save_outlined),
            label: const Text('Choose output'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              minimumSize: const Size(
                double.infinity,
                AppSpacing.buttonHeight,
              ),
              side: const BorderSide(color: AppColors.lightBorder),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FieldInput extends StatefulWidget {
  const _FieldInput({
    required this.field,
    required this.initialValue,
    required this.onChanged,
  });

  final ScannerPdfToolField field;
  final Object? initialValue;
  final ValueChanged<Object?> onChanged;

  @override
  State<_FieldInput> createState() => _FieldInputState();
}

class _FieldInputState extends State<_FieldInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.initialValue?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.field.label,
          style: AppTextStyles.caption.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        TextField(
          controller: _controller,
          onChanged: widget.onChanged,
          obscureText:
              widget.field.type == ScannerPdfToolFieldType.password,
          style: AppTextStyles.body,
          decoration: InputDecoration(
            hintText: widget.field.hint,
            filled: true,
            fillColor: AppColors.lightSurface,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide:
                  const BorderSide(color: AppColors.lightBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide:
                  const BorderSide(color: AppColors.lightBorder),
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
      ],
    );
  }
}