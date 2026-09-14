import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/providers/document_upload_provider.dart';
import 'package:lawlink360/core/features/lawyer_module/lawyer_clients/models/client_post_model.dart';
import 'package:lawlink360/core/features/lawyer_module/lawyer_clients/providers/client_post_provider.dart';
import 'package:lawlink360/core/theme/app_colors.dart';

class PostCaseScreen extends ConsumerStatefulWidget {
  const PostCaseScreen({super.key});

  @override
  ConsumerState<PostCaseScreen> createState() => _PostCaseScreenState();
}

class _PostCaseScreenState extends ConsumerState<PostCaseScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();

  String? _selectedCategory;
  String _consultationPreference = 'Chat';

  final List<String> _categories = const [
    'Civil Law',
    'Criminal Law',
    'Family Law',
    'Property Law',
    'Inheritance Law',
    'Labour Law',
    'Banking & Finance',
    'Corporate & Business',
    'Consumer Law',
    'Tax Law',
    'Immigration Law',
    'Other',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _showAttachmentOptions() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.fromLTRB(18, 12, 18, 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9DEE7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 18),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Add Supporting Files',
                    style: TextStyle(
                      color: Color(0xFF13294B),
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Choose images or legal documents related to your matter.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 11.5,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: _AttachmentOption(
                        icon: Icons.camera_alt_outlined,
                        title: 'Camera',
                        subtitle: 'Take photo',
                        onTap: () async {
                          Navigator.pop(sheetContext);

                          await ref
                              .read(documentUploadProvider.notifier)
                              .takePhoto();
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _AttachmentOption(
                        icon: Icons.photo_library_outlined,
                        title: 'Images',
                        subtitle: 'Choose photos',
                        onTap: () async {
                          Navigator.pop(sheetContext);

                          await ref
                              .read(documentUploadProvider.notifier)
                              .pickImages();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _AttachmentOption(
                  icon: Icons.description_outlined,
                  title: 'Documents',
                  subtitle: 'PDF, DOC or DOCX',
                  fullWidth: true,
                  onTap: () async {
                    Navigator.pop(sheetContext);

                    await ref
                        .read(documentUploadProvider.notifier)
                        .pickDocuments();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _submitCase() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a legal category.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final attachments = ref.read(documentUploadProvider);

    final post = ClientPostModel(
      id: 'post_${DateTime.now().millisecondsSinceEpoch}',
      clientId: 'current_client',
      clientName: 'Current Client',
      clientImageUrl: null,
      postType: 'Case',
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      legalCategory: _selectedCategory!,
      location: _locationController.text.trim(),
      consultationPreference: _consultationPreference.toLowerCase(),
      attachments: List.unmodifiable(
        attachments.map((attachment) => attachment.path),
      ),
      postedAt: DateTime.now(),
      replyCount: 0,
    );

    ref.read(clientPostProvider.notifier).addPost(post);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Your case has been posted for verified lawyers.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );

    ref.read(documentUploadProvider.notifier).clearAll();

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF13294B);
    const gold = Color(0xFFD4AF37);
    const background = Color(0xFFF7F9FC);

    final attachments = ref.watch(documentUploadProvider);

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Post Your Case',
          style: TextStyle(
            color: navy,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: navy),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _IntroCard(
                  navy: navy,
                  gold: gold,
                ),
                const SizedBox(height: 22),
                const _SectionHeading(
                  title: 'Case Information',
                  subtitle: 'Tell lawyers what legal help you need.',
                ),
                const SizedBox(height: 14),
                const _FieldLabel(
                  label: 'Case Title',
                  requiredField: true,
                ),
                const SizedBox(height: 7),
                _StyledTextField(
                  controller: _titleController,
                  hintText: 'e.g. Property ownership dispute',
                  prefixIcon: Icons.title_rounded,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a case title.';
                    }

                    if (value.trim().length < 5) {
                      return 'Please enter a more descriptive title.';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 17),
                const _FieldLabel(
                  label: 'Legal Category',
                  requiredField: true,
                ),
                const SizedBox(height: 7),
                DropdownButtonFormField<String>(
                  initialValue: _selectedCategory,
                  decoration: _inputDecoration(
                    hintText: 'Select legal category',
                    prefixIcon: Icons.gavel_rounded,
                  ),
                  items: _categories
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                ),
                const SizedBox(height: 17),
                const _FieldLabel(
                  label: 'Matter Description',
                  requiredField: true,
                ),
                const SizedBox(height: 7),
                _StyledTextField(
                  controller: _descriptionController,
                  hintText:
                      'Describe your legal matter, important facts, and what help you need...',
                  prefixIcon: Icons.description_outlined,
                  maxLines: 7,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please describe your legal matter.';
                    }

                    if (value.trim().length < 20) {
                      return 'Please provide a little more detail.';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 17),
                const _FieldLabel(
                  label: 'Location',
                  requiredField: true,
                ),
                const SizedBox(height: 7),
                _StyledTextField(
                  controller: _locationController,
                  hintText: 'e.g. Lahore, Punjab',
                  prefixIcon: Icons.location_on_outlined,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter the matter location.';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 24),
                const _SectionHeading(
                  title: 'Consultation Preference',
                  subtitle: 'How would you prefer to speak with a lawyer?',
                ),
                const SizedBox(height: 14),
                _ConsultationSelector(
                  selected: _consultationPreference,
                  onChanged: (value) {
                    setState(() {
                      _consultationPreference = value;
                    });
                  },
                ),
                const SizedBox(height: 24),
                const _SectionHeading(
                  title: 'Supporting Documents',
                  subtitle:
                      'Optional — attach relevant documents or images.',
                ),
                const SizedBox(height: 14),
                _AttachmentCard(
                  attachments: attachments,
                  onAdd: _showAttachmentOptions,
                  onRemove: (index) {
                    ref
                        .read(documentUploadProvider.notifier)
                        .removeAttachment(index);
                  },
                ),
                const SizedBox(height: 28),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.black.withValues(alpha: 0.05),
                    ),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.verified_user_outlined,
                        color: Color(0xFFD4AF37),
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Your case will be visible to verified lawyers so they can review your requirements and offer legal assistance.',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 11.5,
                            height: 1.45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton.icon(
                    onPressed: _submitCase,
                    icon: const Icon(Icons.send_rounded),
                    label: const Text(
                      'Post Case',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hintText,
    required IconData prefixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        color: Colors.grey,
        fontSize: 12,
      ),
      prefixIcon: Icon(
        prefixIcon,
        color: const Color(0xFF13294B),
        size: 20,
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 15,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Color(0xFFE4E8EF),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Color(0xFFE4E8EF),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Color(0xFFD4AF37),
          width: 1.4,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Colors.redAccent,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Colors.redAccent,
          width: 1.4,
        ),
      ),
    );
  }
}

class _IntroCard extends StatelessWidget {
  final Color navy;
  final Color gold;

  const _IntroCard({
    required this.navy,
    required this.gold,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF13294B),
            Color(0xFF1D3B68),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: gold.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              Icons.gavel_rounded,
              color: gold,
              size: 25,
            ),
          ),
          const SizedBox(width: 13),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Find the right legal help',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Post your matter once and let verified lawyers review your requirements.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 11.5,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionHeading({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF13294B);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: navy,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          subtitle,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 11.5,
          ),
        ),
      ],
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String label;
  final bool requiredField;

  const _FieldLabel({
    required this.label,
    this.requiredField = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF13294B),
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (requiredField)
          const Text(
            ' *',
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 12.5,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }
}

class _StyledTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final int maxLines;
  final String? Function(String?)? validator;

  const _StyledTextField({
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.maxLines = 1,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      textInputAction:
          maxLines > 1 ? TextInputAction.newline : TextInputAction.next,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
        prefixIcon: maxLines == 1
            ? Icon(
                prefixIcon,
                color: const Color(0xFF13294B),
                size: 20,
              )
            : Padding(
                padding: const EdgeInsets.only(
                  left: 14,
                  right: 10,
                  bottom: 72,
                ),
                child: Icon(
                  prefixIcon,
                  color: const Color(0xFF13294B),
                  size: 20,
                ),
              ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Color(0xFFE4E8EF),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Color(0xFFE4E8EF),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Color(0xFFD4AF37),
            width: 1.4,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.redAccent,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.redAccent,
            width: 1.4,
          ),
        ),
      ),
    );
  }
}

class _ConsultationSelector extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  const _ConsultationSelector({
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const gold = Color(0xFFD4AF37);

    const options = [
      (
        label: 'Chat',
        icon: Icons.chat_bubble_outline_rounded,
      ),
      (
        label: 'Voice',
        icon: Icons.phone_outlined,
      ),
      (
        label: 'Video',
        icon: Icons.videocam_outlined,
      ),
      (
        label: 'In-person',
        icon: Icons.location_on_outlined,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: options.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 2.8,
      ),
      itemBuilder: (context, index) {
        final option = options[index];
        final isSelected = selected == option.label;

        return InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () => onChanged(option.label),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: isSelected
                  ? gold.withValues(alpha: 0.10)
                  : Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isSelected
                    ? gold
                    : const Color(0xFFE4E8EF),
                width: isSelected ? 1.4 : 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  option.icon,
                  color: isSelected
                      ? gold
                      : const Color(0xFF13294B),
                  size: 19,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    option.label,
                    style: TextStyle(
                      color: isSelected
                          ? const Color(0xFF13294B)
                          : Colors.grey.shade700,
                      fontSize: 11.5,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                ),
                if (isSelected)
                  const Icon(
                    Icons.check_circle_rounded,
                    color: gold,
                    size: 17,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AttachmentOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool fullWidth;

  const _AttachmentOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F9FC),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: const Color(0xFFE4E8EF),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFD4AF37).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: const Color(0xFFD4AF37),
                size: 21,
              ),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF13294B),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            if (fullWidth)
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF13294B),
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}

class _AttachmentCard extends StatelessWidget {
  final List<DocumentAttachment> attachments;
  final VoidCallback onAdd;
  final ValueChanged<int> onRemove;

  const _AttachmentCard({
    required this.attachments,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onAdd,
          borderRadius: BorderRadius.circular(17),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 22,
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(
                color: const Color(0xFFE4E8EF),
              ),
            ),
            child: const Column(
              children: [
                Icon(
                  Icons.cloud_upload_outlined,
                  color: Color(0xFFD4AF37),
                  size: 30,
                ),
                SizedBox(height: 8),
                Text(
                  'Add supporting documents',
                  style: TextStyle(
                    color: Color(0xFF13294B),
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'PDF, DOC, DOCX, images or camera photos',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        if (attachments.isNotEmpty) ...[
          const SizedBox(height: 10),
          ...List.generate(
            attachments.length,
            (index) {
              final attachment = attachments[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 7),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFE4E8EF),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      attachment.isImage
                          ? Icons.image_outlined
                          : Icons.description_outlined,
                      color: const Color(0xFF13294B),
                      size: 20,
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: Text(
                        attachment.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF13294B),
                          fontSize: 11.5,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => onRemove(index),
                      icon: const Icon(
                        Icons.close_rounded,
                        size: 18,
                      ),
                      color: Colors.grey,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 30,
                        minHeight: 30,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ],
    );
  }
}