import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../data/copy_house_request_constants.dart';
import '../models/copy_house_request.dart';
import '../providers/copy_house_request_providers.dart';
import '../widgets/copy_house_form_fields.dart';
import '../widgets/copy_house_image_attachments.dart';

class RegisteredDocumentCopyFormScreen
    extends ConsumerStatefulWidget {
  const RegisteredDocumentCopyFormScreen({super.key});

  @override
  ConsumerState<RegisteredDocumentCopyFormScreen> createState() =>
      _RegisteredDocumentCopyFormScreenState();
}

class _RegisteredDocumentCopyFormScreenState
    extends ConsumerState<RegisteredDocumentCopyFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _picker = CopyHouseImagePicker();

  final _bookNumberController = TextEditingController();
  final _volumeNumberController = TextEditingController();
  final _documentNumberController = TextEditingController();
  final _datedController = TextEditingController();

  String? _subtype;
  List<XFile> _images = <XFile>[];
  bool _submitting = false;

  @override
  void dispose() {
    _bookNumberController.dispose();
    _volumeNumberController.dispose();
    _documentNumberController.dispose();
    _datedController.dispose();
    super.dispose();
  }

  Future<void> _pickDated() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year + 20),
    );
    if (picked != null) {
      _datedController.text =
          '${picked.year.toString().padLeft(4, '0')}-'
          '${picked.month.toString().padLeft(2, '0')}-'
          '${picked.day.toString().padLeft(2, '0')}';
    }
  }

  Future<void> _addImages() async {
    final picked = await _picker.pickMultiple();
    if (picked.isEmpty) return;
    setState(() {
      _images = <XFile>[..._images, ...picked];
    });
  }

  void _removeImage(int index) {
    if (index < 0 || index >= _images.length) return;
    setState(() {
      _images = <XFile>[
        for (var i = 0; i < _images.length; i++)
          if (i != index) _images[i],
      ];
    });
  }

  Future<void> _submit() async {
    if (_submitting) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      _showMessage(
        'Please sign in to submit a request.',
        isError: true,
      );
      return;
    }

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      _submitting = true;
    });

    final details = <String, dynamic>{
      'bookNumber': _bookNumberController.text.trim(),
      'volumeNumber': _volumeNumberController.text.trim(),
      'documentNumber': _documentNumberController.text.trim(),
      'dated': _datedController.text.trim(),
      // No imageUrls: images are local-only in this phase. We do not
      // claim the images were uploaded or submitted.
    };

    final request = CopyHouseRequest(
      serviceId: registeredDocumentCopiesServiceId,
      serviceSubtype: _subtype ?? '',
      submittedBy: user.uid,
      status: initialCopyHouseRequestStatus,
      caseType: '',
      caseStatus: '',
      courtOrJurisdiction: '',
      purpose: '',
      serviceDetails: details,
    );

    try {
      final reference = await ref
          .read(copyHouseRequestRepositoryProvider)
          .submitRequest(request);

      if (!mounted) return;

      setState(() {
        _submitting = false;
      });

      await _showConfirmation(reference);
    } catch (error, stackTrace) {
      debugPrint(
        'CopyHouse registered document submission failed: $error',
      );
      debugPrintStack(stackTrace: stackTrace);

      if (!mounted) return;

      setState(() {
        _submitting = false;
      });

      _showMessage(
        'Your request could not be submitted. Please try again.',
        isError: true,
      );
    }
  }

  void _showMessage(String message, {required bool isError}) {
    final colorScheme = Theme.of(context).colorScheme;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? colorScheme.error : null,
      ),
    );
  }

  Future<void> _showConfirmation(String reference) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        final colorScheme = Theme.of(context).colorScheme;

        return AlertDialog(
          title: const Text('Request received'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your request has been received by LawLink360.',
                style: AppTextStyles.body.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Reference: $reference',
                style: AppTextStyles.body.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'This confirms receipt only. Any pictures you selected '
                'were not uploaded or attached to your request.',
                style: AppTextStyles.caption.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );

    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          'Registered Document Copy',
          style: AppTextStyles.title.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.md,
            AppSpacing.md,
            AppSpacing.xl,
          ),
          physics: const BouncingScrollPhysics(),
          children: [
            Text(
              'Registered Document Copies',
              style: AppTextStyles.title.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Provide the details of the registered document you are '
              'requesting. Fields marked with * are required.',
              style: AppTextStyles.bodySmall.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.4,
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            CopyHouseDropdownField(
              label: 'Document Type',
              value: _subtype,
              items: registeredDocumentSubtypes,
              labels: registeredDocumentSubtypeLabels,
              onChanged: (v) => setState(() => _subtype = v),
              validator: (v) =>
                  v == null || v.isEmpty ? 'Required' : null,
            ),

            const SizedBox(height: AppSpacing.md),

            CopyHouseTextField(
              controller: _bookNumberController,
              label: 'Book No.',
              maxLength: maxBookNumberLength,
            ),

            const SizedBox(height: AppSpacing.md),

            CopyHouseTextField(
              controller: _volumeNumberController,
              label: 'Volume No.',
              maxLength: maxVolumeNumberLength,
            ),

            const SizedBox(height: AppSpacing.md),

            CopyHouseTextField(
              controller: _documentNumberController,
              label: 'Document No.',
              maxLength: maxDocumentNumberLength,
            ),

            const SizedBox(height: AppSpacing.md),

            CopyHouseDateField(
              controller: _datedController,
              label: 'Dated',
              onTap: _pickDated,
            ),

            const SizedBox(height: AppSpacing.lg),

            CopyHouseImageAttachments(
              images: _images,
              onAdd: _addImages,
              onRemove: _removeImage,
            ),

            const SizedBox(height: AppSpacing.lg),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton(
                onPressed: _submitting ? null : _submit,
                child: _submitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Submit request'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}