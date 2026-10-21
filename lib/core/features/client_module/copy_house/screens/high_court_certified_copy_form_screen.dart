import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../data/copy_house_request_constants.dart';
import '../models/copy_house_request.dart';
import '../providers/copy_house_request_providers.dart';
import '../widgets/copy_house_form_fields.dart';
import '../widgets/copy_house_image_attachments.dart';

class HighCourtCertifiedCopyFormScreen
    extends ConsumerStatefulWidget {
  const HighCourtCertifiedCopyFormScreen({super.key});

  @override
  ConsumerState<HighCourtCertifiedCopyFormScreen> createState() =>
      _HighCourtCertifiedCopyFormScreenState();
}

class _HighCourtCertifiedCopyFormScreenState
    extends ConsumerState<HighCourtCertifiedCopyFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _picker = CopyHouseImagePicker();

  // Case number: two fields.
  final _caseNumberController = TextEditingController();
  final _caseYearController = TextEditingController();

  // Parties: via CopyHousePartyRow.
  final _firstPartyController = TextEditingController();
  final _secondPartyController = TextEditingController();

  // Peshi dates.
  final _puccaPeshiController = TextEditingController();
  final _kucchaPeshiController = TextEditingController();

  // Justices.
  final List<TextEditingController> _justiceControllers =
      <TextEditingController>[];

  // District.
  final _districtController = TextEditingController();

  // Requested copy details.
  final List<TextEditingController> _copyDetailControllers =
      <TextEditingController>[];

  // Local-only images.
  List<XFile> _images = <XFile>[];

  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < highCourtInitialJusticeCount; i++) {
      _justiceControllers.add(TextEditingController());
    }
    for (var i = 0; i < highCourtInitialCopyDetailCount; i++) {
      _copyDetailControllers.add(TextEditingController());
    }
    // Wire text listeners so peshi date fields update their enabled
    // state in the form as soon as text changes.
    _puccaPeshiController.addListener(_onPeshiChanged);
    _kucchaPeshiController.addListener(_onPeshiChanged);
  }

  void _onPeshiChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _caseNumberController.dispose();
    _caseYearController.dispose();
    _firstPartyController.dispose();
    _secondPartyController.dispose();
    _puccaPeshiController.removeListener(_onPeshiChanged);
    _kucchaPeshiController.removeListener(_onPeshiChanged);
    _puccaPeshiController.dispose();
    _kucchaPeshiController.dispose();
    for (final c in _justiceControllers) {
      c.dispose();
    }
    _districtController.dispose();
    for (final c in _copyDetailControllers) {
      c.dispose();
    }
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Dynamic inputs
  // ---------------------------------------------------------------------------

  void _addJustice() {
    setState(() {
      _justiceControllers.add(TextEditingController());
    });
  }

  void _removeJustice(int index) {
    if (_justiceControllers.length <= highCourtInitialJusticeCount) return;
    if (index < 0 || index >= _justiceControllers.length) return;
    final c = _justiceControllers.removeAt(index);
    c.dispose();
    setState(() {});
  }

  void _addCopyDetail() {
    setState(() {
      _copyDetailControllers.add(TextEditingController());
    });
  }

  void _removeCopyDetail(int index) {
    if (_copyDetailControllers.length <=
        highCourtInitialCopyDetailCount) {
      return;
    }
    if (index < 0 || index >= _copyDetailControllers.length) return;
    final c = _copyDetailControllers.removeAt(index);
    c.dispose();
    setState(() {});
  }

  // ---------------------------------------------------------------------------
  // Date pickers (per side; each clears the other side)
  // ---------------------------------------------------------------------------

  Future<void> _pickPuccaPeshi() async {
    if (_kucchaPeshiController.text.isNotEmpty) return;
    await _pickDateInto(_puccaPeshiController);
  }

  Future<void> _pickKucchaPeshi() async {
    if (_puccaPeshiController.text.isNotEmpty) return;
    await _pickDateInto(_kucchaPeshiController);
  }

  Future<void> _pickDateInto(TextEditingController controller) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year + 20),
    );
    if (picked != null) {
      controller.text =
          '${picked.year.toString().padLeft(4, '0')}-'
          '${picked.month.toString().padLeft(2, '0')}-'
          '${picked.day.toString().padLeft(2, '0')}';
    }
  }

  void _clearPuccaPeshi() {
    _puccaPeshiController.clear();
  }

  void _clearKucchaPeshi() {
    _kucchaPeshiController.clear();
  }

  // ---------------------------------------------------------------------------
  // Images
  // ---------------------------------------------------------------------------

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

  // ---------------------------------------------------------------------------
  // Submission
  // ---------------------------------------------------------------------------

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

    final hasPucca = _puccaPeshiController.text.trim().isNotEmpty;
    final hasKuccha = _kucchaPeshiController.text.trim().isNotEmpty;
    if (hasPucca == hasKuccha) {
      // Both empty, or somehow both set: refuse with a clear message.
      _showMessage(
        'Select exactly one Peshi date: Pucca or Kuccha.',
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

    final justices = _justiceControllers
        .map((c) => c.text.trim())
        .where((s) => s.isNotEmpty)
        .toList(growable: false);

    final copyDetails = _copyDetailControllers
        .map((c) => c.text.trim())
        .where((s) => s.isNotEmpty)
        .toList(growable: false);

    final peshiType = hasPucca
        ? highCourtPeshiTypePucca
        : highCourtPeshiTypeKuccha;
    final peshiDate = hasPucca
        ? _puccaPeshiController.text.trim()
        : _kucchaPeshiController.text.trim();

    final details = <String, dynamic>{
      'caseNumber': _caseNumberController.text.trim(),
      'caseYear': _caseYearController.text.trim(),
      'firstParty': _firstPartyController.text.trim(),
      'secondParty': _secondPartyController.text.trim(),
      'peshiType': peshiType,
      'peshiDate': peshiDate,
      'justices': justices,
      'district': _districtController.text.trim(),
      'requestedCopyDetails': copyDetails,
      // No image data stored in this phase.
    };

    final request = CopyHouseRequest(
      serviceId: highCourtCertifiedCopiesServiceId,
      serviceSubtype: '',
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
      debugPrint('CopyHouse high court submission failed: $error');
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
                'This confirms receipt only. It is not confirmation '
                'of court acceptance or completion.',
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

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final puccaLocked = _kucchaPeshiController.text.isNotEmpty;
    final kucchaLocked = _puccaPeshiController.text.isNotEmpty;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          'High Court Certified Copy',
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
              'High Court Certified Copies',
              style: AppTextStyles.title.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Provide the details of the record you are requesting. '
              'Fields marked with * are required.',
              style: AppTextStyles.bodySmall.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.4,
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            // ---- Case No. -------------------------------------------------
            _CaseNumberRow(
              numberController: _caseNumberController,
              yearController: _caseYearController,
            ),

            const SizedBox(height: AppSpacing.md),

            // ---- First Party vs. Second Party -----------------------------
            CopyHousePartyRow(
              firstController: _firstPartyController,
              secondController: _secondPartyController,
              maxPartyNameLength: maxPartyNameLength,
            ),

            const SizedBox(height: AppSpacing.md),

            // ---- Peshi dates (exactly one) --------------------------------
            _PeshiDateField(
              controller: _puccaPeshiController,
              label: 'Pucca Peshi Decided On',
              locked: puccaLocked,
              onPick: _pickPuccaPeshi,
              onClear: _clearPuccaPeshi,
            ),
            const SizedBox(height: AppSpacing.md),
            _PeshiDateField(
              controller: _kucchaPeshiController,
              label: 'Kuccha Peshi Decided On',
              locked: kucchaLocked,
              onPick: _pickKucchaPeshi,
              onClear: _clearKucchaPeshi,
            ),

            const SizedBox(height: AppSpacing.md),

            // ---- Justices -------------------------------------------------
            Text(
              'Justices',
              style: AppTextStyles.body.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            _DynamicTextFieldList(
              controllers: _justiceControllers,
              labelBuilder: (i) => 'Mr. Justice',
              maxLength: maxHighCourtJusticeNameLength,
              initialCount: highCourtInitialJusticeCount,
              onAdd: _addJustice,
              onRemove: _removeJustice,
              addLabel: 'Add Another Justice',
              requireAtLeastOne: true,
              atLeastOneMessage:
                  'Enter at least one justice name',
            ),

            const SizedBox(height: AppSpacing.md),

            // ---- District -------------------------------------------------
            CopyHouseTextField(
              controller: _districtController,
              label: 'District',
              required: true,
              maxLength: maxHighCourtDistrictLength,
            ),

            const SizedBox(height: AppSpacing.md),

            // ---- Requested copy details -----------------------------------
            Text(
              'Details of Requested Copy',
              style: AppTextStyles.body.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            _DynamicTextFieldList(
              controllers: _copyDetailControllers,
              labelBuilder: (i) => '${i + 1}. Document detail required',
              maxLength: maxHighCourtCopyDetailLength,
              initialCount: highCourtInitialCopyDetailCount,
              onAdd: _addCopyDetail,
              onRemove: _removeCopyDetail,
              addLabel: 'Add Another Document Detail',
              requireAtLeastOne: true,
              atLeastOneMessage:
                  'Enter at least one requested copy detail',
            ),

            const SizedBox(height: AppSpacing.md),

            // ---- Pictures (optional, local previews) ----------------------
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

// -----------------------------------------------------------------------------
// Local widgets
// -----------------------------------------------------------------------------

class _CaseNumberRow extends StatelessWidget {
  final TextEditingController numberController;
  final TextEditingController yearController;

  const _CaseNumberRow({
    required this.numberController,
    required this.yearController,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: TextFormField(
            controller: numberController,
            maxLength: maxHighCourtCaseNumberLength,
            decoration: const InputDecoration(
              labelText: 'Case No. *',
            ),
            validator: (v) {
              final t = (v ?? '').trim();
              if (t.isEmpty) return 'This field is required';
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.md,
          ),
          child: Text(
            '/ 20',
            style: AppTextStyles.body.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: TextFormField(
            controller: yearController,
            maxLength: highCourtCaseYearLength,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(highCourtCaseYearLength),
            ],
            decoration: const InputDecoration(
              labelText: 'Year *',
              hintText: 'YY',
            ),
            validator: (v) {
              final t = (v ?? '').trim();
              if (t.isEmpty) return 'This field is required';
              if (t.length != highCourtCaseYearLength) {
                return '2 digits';
              }
              if (int.tryParse(t) == null) return 'Numeric';
              return null;
            },
          ),
        ),
      ],
    );
  }
}

class _PeshiDateField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool locked;
  final VoidCallback onPick;
  final VoidCallback onClear;

  const _PeshiDateField({
    required this.controller,
    required this.label,
    required this.locked,
    required this.onPick,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            readOnly: true,
            enabled: !locked,
            onTap: locked ? null : onPick,
            decoration: InputDecoration(
              labelText: label,
              suffixIcon: const Icon(Icons.calendar_today_rounded),
            ),
          ),
        ),
        if (controller.text.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(
              left: AppSpacing.xs,
              top: AppSpacing.xs,
            ),
            child: IconButton(
              tooltip: 'Clear',
              icon: Icon(
                Icons.close_rounded,
                color: colorScheme.error,
              ),
              onPressed: onClear,
            ),
          ),
      ],
    );
  }
}

class _DynamicTextFieldList extends StatelessWidget {
  final List<TextEditingController> controllers;
  final String Function(int index) labelBuilder;
  final int maxLength;
  final int initialCount;
  final VoidCallback onAdd;
  final void Function(int index) onRemove;
  final String addLabel;
  final bool requireAtLeastOne;
  final String atLeastOneMessage;

  const _DynamicTextFieldList({
    required this.controllers,
    required this.labelBuilder,
    required this.maxLength,
    required this.initialCount,
    required this.onAdd,
    required this.onRemove,
    required this.addLabel,
    this.requireAtLeastOne = false,
    this.atLeastOneMessage = 'This field is required',
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < controllers.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controllers[i],
                    maxLength: maxLength,
                    decoration: InputDecoration(
                      labelText: labelBuilder(i),
                    ),
                    validator: (v) {
                      final t = (v ?? '').trim();
                      // Only the first field of a "require at least one"
                      // list needs to enforce emptiness at the field level;
                      // the at-least-one check is applied at submit time.
                      if (requireAtLeastOne && i == 0) {
                        // Do not enforce per-field; let submit handle it.
                        return null;
                      }
                      if (controllers.length > initialCount &&
                          v != null &&
                          v.isNotEmpty &&
                          t.isEmpty) {
                        return 'Remove whitespace or clear the field';
                      }
                      return null;
                    },
                  ),
                ),
                if (controllers.length > initialCount)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: AppSpacing.xs,
                      top: AppSpacing.xs,
                    ),
                    child: IconButton(
                      tooltip: 'Remove',
                      icon: Icon(
                        Icons.close_rounded,
                        color: colorScheme.error,
                      ),
                      onPressed: () => onRemove(i),
                    ),
                  ),
              ],
            ),
          ),
        OutlinedButton.icon(
          onPressed: onAdd,
          icon: const Icon(Icons.add_rounded),
          label: Text(addLabel),
        ),
      ],
    );
  }
}