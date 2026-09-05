import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/draft_model.dart';
import '../providers/draft_providers.dart';

class DraftEditorScreen extends ConsumerStatefulWidget {
  const DraftEditorScreen({super.key});

  @override
  ConsumerState<DraftEditorScreen> createState() =>
      _DraftEditorScreenState();
}

class _DraftEditorScreenState
    extends ConsumerState<DraftEditorScreen> {
  final TextEditingController _titleController =
      TextEditingController();

  final TextEditingController _contentController =
      TextEditingController();

  DraftModel? _draft;

  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_initialized) return;

    _initialized = true;

    final draftId =
        ModalRoute.of(context)?.settings.arguments as String?;

    if (draftId != null) {
      final draft =
          ref.read(draftProvider.notifier).getDraft(draftId);

      if (draft != null) {
        _draft = draft;

        _titleController.text = draft.title;
        _contentController.text = draft.content;
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    final draft = _draft;

    if (draft == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Draft not found.'),
        ),
      );
      return;
    }

    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter draft title.'),
        ),
      );
      return;
    }

    final updatedDraft = draft.copyWith(
      title: title,
      content: content,
      updatedAt: DateTime.now(),
    );

    ref
        .read(draftProvider.notifier)
        .updateDraft(updatedDraft);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Draft updated successfully.'),
        behavior: SnackBarBehavior.floating,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final draft = _draft;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        backgroundColor: const Color(0xFF13294B),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Edit Draft',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: draft == null ? null : _saveChanges,
            icon: const Icon(Icons.save_outlined),
            tooltip: 'Save',
          ),
        ],
      ),

      body: draft == null
          ? const Center(
              child: Text(
                'Draft not found.',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF13294B),
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'Draft Title',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF13294B),
                  ),
                ),

                const SizedBox(height: 7),

                TextField(
                  controller: _titleController,
                  decoration: _inputDecoration(
                    'Enter draft title',
                  ),
                ),

                const SizedBox(height: 18),

                Row(
                  children: [
                    const Text(
                      'Category',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF13294B),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      draft.category,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF9A7A00),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                const Text(
                  'Draft Content',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF13294B),
                  ),
                ),

                const SizedBox(height: 7),

                TextField(
                  controller: _contentController,
                  maxLines: 18,
                  textAlignVertical:
                      TextAlignVertical.top,
                  decoration: _inputDecoration(
                    'Write your draft here...',
                  ),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: _saveChanges,
                    icon: const Icon(
                      Icons.save_outlined,
                    ),
                    label: const Text(
                      'Save Changes',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF13294B),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Color(0xFFE5E7EB),
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Color(0xFFE5E7EB),
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Color(0xFF13294B),
          width: 1.2,
        ),
      ),

      contentPadding: const EdgeInsets.all(14),
    );
  }
}