
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/draft_providers.dart';
import '../services/drafting_service.dart';

class CreateDraftScreen extends ConsumerStatefulWidget {
  const CreateDraftScreen({super.key});

  @override
  ConsumerState<CreateDraftScreen> createState() =>
      _CreateDraftScreenState();
}

class _CreateDraftScreenState
    extends ConsumerState<CreateDraftScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  String _category = 'Applications';

  final List<String> _categories = [
    'Applications',
    'Legal Notices',
    'Criminal',
    'Civil',
    'Family',
    'Property',
    'Other',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveDraft() {
  if (_titleController.text.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please enter draft title'),
      ),
    );
    return;
  }

  final draft = DraftingService.createDraft(
    title: _titleController.text.trim(),
    category: _category,
    content: _contentController.text.trim(),
  );

  ref.read(draftProvider.notifier).addDraft(draft);

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Draft saved successfully'),
    ),
  );

  Navigator.pop(context);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        backgroundColor: const Color(0xFF13294B),
        foregroundColor: Colors.white,
        title: const Text('Create Draft'),
      ),

      body: ListView(
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

          const Text(
            'Category',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF13294B),
            ),
          ),

          const SizedBox(height: 7),

          DropdownButtonFormField<String>(
            value: _category,
            decoration: _inputDecoration('Select category'),
            items: _categories
                .map(
                  (category) => DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _category = value;
                });
              }
            },
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
            maxLines: 12,
            decoration: _inputDecoration(
              'Write your draft here...',
            ),
          ),

          const SizedBox(height: 24),

          SizedBox(
            height: 50,
            child: ElevatedButton.icon(
              onPressed: _saveDraft,
              icon: const Icon(Icons.save_outlined),
              label: const Text('Save Draft'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF13294B),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
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
    );
  }
}
