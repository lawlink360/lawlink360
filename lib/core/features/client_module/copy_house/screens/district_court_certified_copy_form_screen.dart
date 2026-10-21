import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../data/copy_house_request_constants.dart';
import '../models/copy_house_request.dart';
import '../providers/copy_house_request_providers.dart';
import '../widgets/copy_house_form_fields.dart';

class DistrictCourtCertifiedCopyFormScreen extends ConsumerStatefulWidget {
  const DistrictCourtCertifiedCopyFormScreen({super.key});

  @override
  ConsumerState<DistrictCourtCertifiedCopyFormScreen> createState() =>
      _DistrictCourtCertifiedCopyFormScreenState();
}

class _DistrictCourtCertifiedCopyFormScreenState
    extends ConsumerState<DistrictCourtCertifiedCopyFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Field 3 – parties
  final _firstPartyController = TextEditingController();
  final _secondPartyController = TextEditingController();

  // Field 4 – case id
  final _caseNumberController = TextEditingController();

  // Field 5 – criminal details
  final _firNumberController = TextEditingController();
  final _firYearController = TextEditingController();
  final _policeStationController = TextEditingController();
  final _offenceController = TextEditingController();
  final _datedController = TextEditingController();

  // Field 6 – jurisdiction
  final _jurisdictionController = TextEditingController();

  // Field 7 – court / judge
  final _courtOrJudgeController = TextEditingController();

  // Field 8 – case dates
  final _caseDecidedOnController = TextEditingController();
  final _nextHearingDateController = TextEditingController();

  // Field 9 – dynamic document list
  final List<TextEditingController> _documentControllers =
      <TextEditingController>[];

  // Field 10 – purpose
  final _purposeController = TextEditingController();

  // Field 11 – additional information
  final _additionalInformationController = TextEditingController();

  // Field 1 & 2 – kept unchanged at the top
  String? _caseType;
  String? _caseStatus;

  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < initialDocumentInputCount; i++) {
      _documentControllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    _firstPartyController.dispose();
    _secondPartyController.dispose();
    _caseNumberController.dispose();
    _firNumberController.dispose();
    _firYearController.dispose();
    _policeStationController.dispose();
    _offenceController.dispose();
    _datedController.dispose();
    _jurisdictionController.dispose();
    _courtOrJudgeController.dispose();
    _caseDecidedOnController.dispose();
    _nextHearingDateController.dispose();
    for (final c in _documentControllers) {
      c.dispose();
    }
    _purposeController.dispose();
    _additionalInformationController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Date pickers
  // ---------------------------------------------------------------------------

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

  // ---------------------------------------------------------------------------
  // Dynamic document list
  // ---------------------------------------------------------------------------

  void _addDocumentInput() {
    setState(() {
      _documentControllers.add(TextEditingController());
    });
  }

  void _removeDocumentInput(int index) {
    if (_documentControllers.length <= initialDocumentInputCount) return;
    if (index < 0 || index >= _documentControllers.length) return;
    final controller = _documentControllers.removeAt(index);
    controller.dispose();
    setState(() {});
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

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      _submitting = true;
    });

    final documents = _documentControllers
        .map((c) => c.text.trim())
        .where((s) => s.isNotEmpty)
        .toList(growable: false);

    final firstParty = _firstPartyController.text.trim();
    final secondParty = _secondPartyController.text.trim();
    final combinedCaseTitle = '$firstParty vs. $secondParty'.trim();

    final request = CopyHouseRequest(
      serviceId: districtCourtCertifiedCopiesServiceId,
      submittedBy: user.uid,
      status: initialCopyHouseRequestStatus,
      caseType: _caseType ?? '',
      caseStatus: _caseStatus ?? '',
      firstParty: firstParty,
      secondParty: secondParty,
      caseTitle: combinedCaseTitle,
      caseNumber: _caseNumberController.text.trim(),
      firNumber: _firNumberController.text.trim(),
      firYear: _firYearController.text.trim(),
      policeStation: _policeStationController.text.trim(),
      offence: _offenceController.text.trim(),
      dated: _datedController.text.trim(),
      courtOrJurisdiction: _jurisdictionController.text.trim(),
      judge: _courtOrJudgeController.text.trim(),
      caseDecidedOn: _caseDecidedOnController.text.trim(),
      nextHearingDate: _nextHearingDateController.text.trim(),
      recordRequested: documents.join('\n'),
      recordRequestedList: documents,
      purpose: _purposeController.text.trim(),
      additionalInformation:
          _additionalInformationController.text.trim(),
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
      debugPrint('CopyHouse submission failed: $error');
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

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          'Certified Copy Request',
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
              'District Court Certified Copies',
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

            // -------------------------------------------------------------
            // Fields 1 & 2 – unchanged, still first
            // -------------------------------------------------------------
            CopyHouseDropdownField(
              label: 'Case type',
              value: _caseType,
              items: allowedCaseTypes,
              onChanged: (v) => setState(() => _caseType = v),
              validator: (v) =>
                  v == null || v.isEmpty ? 'Required' : null,
            ),

            const SizedBox(height: AppSpacing.md),

            CopyHouseDropdownField(
              label: 'Case status',
              value: _caseStatus,
              items: allowedCaseStatuses,
              onChanged: (v) => setState(() => _caseStatus = v),
              validator: (v) =>
                  v == null || v.isEmpty ? 'Required' : null,
            ),

            const SizedBox(height: AppSpacing.md),

            // -------------------------------------------------------------
            // Field 3 – first party vs. second party
            // -------------------------------------------------------------
            Text(
              'Case Title / Party Names',
              style: AppTextStyles.body.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
                        CopyHousePartyRow(
              firstController: _firstPartyController,
              secondController: _secondPartyController,
              maxPartyNameLength: maxPartyNameLength,
            ),

            const SizedBox(height: AppSpacing.md),

            // -------------------------------------------------------------
            // Field 4 – case id
            // -------------------------------------------------------------
            CopyHouseTextField(
              controller: _caseNumberController,
              label: 'Case ID',
              hint: 'Enter Case Number',
              maxLength: maxCaseNumberLength,
            ),

            const SizedBox(height: AppSpacing.md),

            // -------------------------------------------------------------
            // Field 5 – criminal case details (all optional)
            // -------------------------------------------------------------
            Text(
              'Criminal Case Details',
              style: AppTextStyles.body.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            _FirRow(
              numberController: _firNumberController,
              yearController: _firYearController,
            ),

            const SizedBox(height: AppSpacing.md),

            CopyHouseTextField(
              controller: _policeStationController,
              label: 'Police Station',
              maxLength: maxPoliceStationLength,
            ),

            const SizedBox(height: AppSpacing.md),

            CopyHouseTextField(
              controller: _offenceController,
              label: 'Offence',
              maxLength: maxOffenceLength,
            ),

            const SizedBox(height: AppSpacing.md),

            CopyHouseDateField(
              controller: _datedController,
              label: 'Dated',
              onTap: () => _pickDateInto(_datedController),
            ),

            const SizedBox(height: AppSpacing.md),

            // -------------------------------------------------------------
            // Field 6 – jurisdiction / location
            // -------------------------------------------------------------
            CopyHouseTextField(
              controller: _jurisdictionController,
              label: 'Jurisdiction / Location',
              required: true,
              maxLength: maxJurisdictionLength,
            ),

            const SizedBox(height: AppSpacing.md),

            // -------------------------------------------------------------
            // Field 7 – court / judge name
            // -------------------------------------------------------------
            CopyHouseTextField(
              controller: _courtOrJudgeController,
              label: 'Court / Judge Name',
              maxLength: maxCourtOrJudgeLength,
            ),

            const SizedBox(height: AppSpacing.md),

            // -------------------------------------------------------------
            // Field 8 – case dates
            // -------------------------------------------------------------
            CopyHouseDateField(
              controller: _caseDecidedOnController,
              label: 'Case Decided On',
              onTap: () => _pickDateInto(_caseDecidedOnController),
            ),

            const SizedBox(height: AppSpacing.md),

            CopyHouseDateField(
              controller: _nextHearingDateController,
              label: 'Next Date of Hearing',
              onTap: () => _pickDateInto(_nextHearingDateController),
            ),

            const SizedBox(height: AppSpacing.md),

            // -------------------------------------------------------------
            // Field 9 – dynamic document list
            // -------------------------------------------------------------
            Text(
              'Record Requested',
              style: AppTextStyles.body.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            _DocumentList(
              controllers: _documentControllers,
              onAdd: _addDocumentInput,
              onRemove: _removeDocumentInput,
            ),

            const SizedBox(height: AppSpacing.md),

            // -------------------------------------------------------------
            // Field 10 – purpose
            // -------------------------------------------------------------
            CopyHouseTextField(
              controller: _purposeController,
              label: 'Purpose',
              required: true,
              maxLength: maxPurposeLength,
              maxLines: 3,
            ),

            const SizedBox(height: AppSpacing.md),

            // -------------------------------------------------------------
            // Field 11 – additional information
            // -------------------------------------------------------------
            CopyHouseTextField(
              controller: _additionalInformationController,
              label: 'Additional information (optional)',
              maxLength: maxAdditionalInformationLength,
              maxLines: 4,
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

class _FirRow extends StatelessWidget {
  final TextEditingController numberController;
  final TextEditingController yearController;

  const _FirRow({
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
            maxLength: maxFirNumberLength,
            decoration: const InputDecoration(
              labelText: 'Case FIR No.',
            ),
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
            maxLength: maxFirYearLength,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Year',
              hintText: 'YYYY',
            ),
            validator: (v) {
              final t = (v ?? '').trim();
              if (t.isEmpty) return null;
              if (t.length != 4) return '4 digits';
              if (int.tryParse(t) == null) return 'Numeric';
              return null;
            },
          ),
        ),
      ],
    );
  }
}

class _DocumentList extends StatelessWidget {
  final List<TextEditingController> controllers;
  final VoidCallback onAdd;
  final void Function(int) onRemove;

  const _DocumentList({
    required this.controllers,
    required this.onAdd,
    required this.onRemove,
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
                    maxLength: maxRecordDocumentLength,
                    decoration: InputDecoration(
                      labelText: '${i + 1}. Document required',
                    ),
                    validator: (v) {
                      final t = (v ?? '').trim();
                      if (i < initialDocumentInputCount) {
                        if (t.isEmpty) return 'This field is required';
                      } else if (v != null && v.isNotEmpty && t.isEmpty) {
                        return 'Remove whitespace or clear the field';
                      }
                      return null;
                    },
                  ),
                ),
                if (controllers.length > initialDocumentInputCount)
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
          label: const Text('Add Another Document'),
        ),
      ],
    );
  }
}