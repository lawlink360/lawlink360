import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../models/document_template.dart';

class DocumentEditorScreen extends StatefulWidget {
  final DocumentTemplate template;

  const DocumentEditorScreen({
    super.key,
    required this.template,
  });

  @override
  State<DocumentEditorScreen> createState() => _DocumentEditorScreenState();
}

class _DocumentEditorScreenState extends State<DocumentEditorScreen> {
  late final TextEditingController controller;
  final ScrollController _scrollController = ScrollController();

  late final String _initialText;
  bool _isDirty = false;

  @override
  void initState() {
    super.initState();

    _initialText = widget.template.body;

    controller = TextEditingController(
      text: _initialText,
    );

    controller.addListener(_handleTextChanged);
  }

  @override
  void dispose() {
    controller.removeListener(_handleTextChanged);
    controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleTextChanged() {
    final bool isNowDirty = controller.text != _initialText;

    if (isNowDirty != _isDirty) {
      setState(() {
        _isDirty = isNowDirty;
      });
    }
  }

  Future<void> _handlePopAttempt() async {
    final bool? shouldDiscard = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Discard changes?'),
          content: const Text(
            'You have unsaved edits. If you leave now, your changes will be lost.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Keep Editing'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Discard'),
            ),
          ],
        );
      },
    );

    if (shouldDiscard == true && mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return PopScope(
      canPop: !_isDirty,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _handlePopAttempt();
      },
      child: Scaffold(
        backgroundColor: colorScheme.surfaceContainerLowest,
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: colorScheme.surface,
          foregroundColor: colorScheme.onSurface,
          surfaceTintColor: Colors.transparent,
          title: Text(
            'Edit Document',
            style: AppTextStyles.title.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          actions: [
            IconButton(
              tooltip: 'Save',
              icon: const Icon(Icons.save_outlined),
              onPressed: () {
                Navigator.pop(
                  context,
                  controller.text,
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(
                color: colorScheme.outlineVariant.withValues(alpha: 0.55),
              ),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withValues(alpha: 0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Scrollbar(
              controller: _scrollController,
              child: TextField(
                controller: controller,
                scrollController: _scrollController,
                expands: true,
                maxLines: null,
                minLines: null,
                textAlignVertical: TextAlignVertical.top,
                style: AppTextStyles.body.copyWith(
                  color: colorScheme.onSurface,
                  height: 1.6,
                ),
                decoration: InputDecoration(
                  hintText: 'Edit your document here...',
                  hintStyle: AppTextStyles.bodySmall.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.55),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(
                    AppSpacing.md,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}