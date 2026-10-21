import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../data/copy_house_request_constants.dart';
import '../models/copy_house_request.dart';
import '../providers/copy_house_request_providers.dart';
import '../widgets/copy_house_form_fields.dart';

class MutationCopyFormScreen extends ConsumerStatefulWidget {
  const MutationCopyFormScreen({super.key});

  @override
  ConsumerState<MutationCopyFormScreen> createState() =>
      _MutationCopyFormScreenState();
}

class _MutationCopyFormScreenState
    extends ConsumerState<MutationCopyFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final _mutationNumberController = TextEditingController();
  final _transactionDateController = TextEditingController();
  final _subRegistrarTownController = TextEditingController();
  final _districtController = TextEditingController();
  final _tehsilController = TextEditingController();
  final _villageMouzaController = TextEditingController();

  bool _submitting = false;

  @override
  void dispose() {
    _mutationNumberController.dispose();
    _transactionDateController.dispose();
    _subRegistrarTownController.dispose();
    _districtController.dispose();
    _tehsilController.dispose();
    _villageMouzaController.dispose();
    super.dispose();
  }

  Future<void> _pickTransactionDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year + 20),
    );
    if (picked != null) {
      _transactionDateController.text =
          '${picked.year.toString().padLeft(4, '0')}-'
          '${picked.month.toString().padLeft(2, '0')}-'
          '${picked.day.toString().padLeft(2, '0')}';
    }
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
      'mutationNumber': _mutationNumberController.text.trim(),
      'transactionDate': _transactionDateController.text.trim(),
      'subRegistrarTown': _subRegistrarTownController.text.trim(),
      'district': _districtController.text.trim(),
      'tehsil': _tehsilController.text.trim(),
      'villageMouza': _villageMouzaController.text.trim(),
    };

    final request = CopyHouseRequest(
      serviceId: mutationCopiesServiceId,
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
      debugPrint('CopyHouse mutation submission failed: $error');
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
                'of completion or delivery.',
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
          'Mutation Copy Request',
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
              'Mutation Copies',
              style: AppTextStyles.title.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Provide the details of the mutation record you are '
              'requesting. Fields marked with * are required.',
              style: AppTextStyles.bodySmall.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.4,
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            CopyHouseTextField(
              controller: _mutationNumberController,
              label: 'Mutation Number',
              required: true,
              maxLength: maxMutationNumberLength,
            ),

            const SizedBox(height: AppSpacing.md),

            CopyHouseDateField(
              controller: _transactionDateController,
              label: 'Transaction / Mutation Date',
              onTap: _pickTransactionDate,
            ),

            const SizedBox(height: AppSpacing.md),

            CopyHouseTextField(
              controller: _subRegistrarTownController,
              label: 'Sub-Registrar Town',
              required: true,
              maxLength: maxSubRegistrarTownLength,
            ),

            const SizedBox(height: AppSpacing.md),

            CopyHouseTextField(
              controller: _districtController,
              label: 'District',
              required: true,
              maxLength: maxDistrictLength,
            ),

            const SizedBox(height: AppSpacing.md),

            CopyHouseTextField(
              controller: _tehsilController,
              label: 'Tehsil',
              required: true,
              maxLength: maxTehsilLength,
            ),

            const SizedBox(height: AppSpacing.md),

            CopyHouseTextField(
              controller: _villageMouzaController,
              label: 'Village / Mouza',
              required: true,
              maxLength: maxVillageMouzaLength,
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