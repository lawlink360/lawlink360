import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../data/copy_house_request_constants.dart';
import '../models/copy_house_request.dart';

/// Renders a list of the current customer's Copy House requests.
///
/// Shows an honest empty state when the list is empty. Does not
/// fabricate statuses or dates beyond what the backend provides.
///
/// Per-service rendering is driven by `serviceId`:
/// * District Court Certified Copies → case-specific fields
/// * Mutation Copies → mutation fields
/// * Registered Document Copies → subtype and document-id fields
/// * High Court Certified Copies → case no., parties, peshi, justices,
///   district, requested copy details
///
/// Old documents (Phase 1) remain readable because every field defaults
/// to an empty value and missing `serviceDetails` reads as `{}`.
class MyRequestsList extends StatelessWidget {
  final List<CopyHouseRequest> requests;

  const MyRequestsList({
    super.key,
    required this.requests,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (requests.isEmpty) {
      return _EmptyState(colorScheme: colorScheme);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final request in requests)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: _RequestCard(
              request: request,
              colorScheme: colorScheme,
            ),
          ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  final ColorScheme colorScheme;

  const _EmptyState({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.55),
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 48,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'No requests yet',
            style: AppTextStyles.title.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Requests you submit will appear here.',
            textAlign: TextAlign.center,
            style: AppTextStyles.body.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  final CopyHouseRequest request;
  final ColorScheme colorScheme;

  const _RequestCard({
    required this.request,
    required this.colorScheme,
  });

  String _title() {
    if (request.serviceId == mutationCopiesServiceId) {
      final n = _str('mutationNumber');
      return n.isEmpty ? 'Mutation Copy Request' : 'Mutation No. $n';
    }
    if (request.serviceId == registeredDocumentCopiesServiceId) {
      final label =
          registeredDocumentSubtypeLabels[request.serviceSubtype];
      return label ?? 'Registered Document Copy';
    }
    if (request.serviceId == highCourtCertifiedCopiesServiceId) {
      final n = _str('caseNumber');
      final y = _str('caseYear');
      if (n.isNotEmpty && y.isNotEmpty) {
        return 'High Court Case No. $n / 20$y';
      }
      return 'High Court Certified Copy';
    }
    if (request.firstParty.isNotEmpty || request.secondParty.isNotEmpty) {
      final first =
          request.firstParty.isEmpty ? '—' : request.firstParty;
      final second =
          request.secondParty.isEmpty ? '—' : request.secondParty;
      return '$first vs. $second';
    }
    if (request.caseTitle.isNotEmpty) return request.caseTitle;
    return 'Copy House Request';
  }

  List<String> _documents() {
    if (request.recordRequestedList.isNotEmpty) {
      return request.recordRequestedList;
    }
    final legacy = request.recordRequested.trim();
    if (legacy.isEmpty) return const <String>[];
    return legacy
        .split('\n')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList(growable: false);
  }

  String _str(String key) {
    return request.serviceDetails[key]?.toString() ?? '';
  }

  List<String> _strList(String key) {
    final raw = request.serviceDetails[key];
    if (raw is List) {
      return raw
          .whereType<String>()
          .where((s) => s.trim().isNotEmpty)
          .toList(growable: false);
    }
    return const <String>[];
  }

  String _highCourtFullCaseNumber() {
    final n = _str('caseNumber');
    final y = _str('caseYear');
    if (n.isEmpty && y.isEmpty) return '';
    if (n.isEmpty) return '/ 20$y';
    if (y.isEmpty) return n;
    return '$n / 20$y';
  }

  String _peshiTypeLabel() {
    final t = _str('peshiType');
    if (t == highCourtPeshiTypePucca) return 'Pucca';
    if (t == highCourtPeshiTypeKuccha) return 'Kuccha';
    return t;
  }

  List<Widget> _bulletedBlock(String title, List<String> items) {
    if (items.isEmpty) return const <Widget>[];
    return <Widget>[
      const SizedBox(height: 4),
      Text(
        title,
        style: AppTextStyles.caption.copyWith(
          color: colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w700,
        ),
      ),
      for (final s in items)
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(
            '• $s',
            style: AppTextStyles.caption.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final documents = _documents();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.55),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _title(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.body.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              _StatusChip(
                status: request.status,
                colorScheme: colorScheme,
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.xs),

          _MetaRow(
            label: 'Service',
            value: request.serviceId,
            colorScheme: colorScheme,
          ),

          // ---- Mutation Copies ----------------------------------------
          if (request.serviceId == mutationCopiesServiceId) ...[
            if (_str('mutationNumber').isNotEmpty)
              _MetaRow(
                label: 'Mutation No.',
                value: _str('mutationNumber'),
                colorScheme: colorScheme,
              ),
            if (_str('transactionDate').isNotEmpty)
              _MetaRow(
                label: 'Date',
                value: _str('transactionDate'),
                colorScheme: colorScheme,
              ),
            if (_str('subRegistrarTown').isNotEmpty)
              _MetaRow(
                label: 'Sub-Registrar',
                value: _str('subRegistrarTown'),
                colorScheme: colorScheme,
              ),
            if (_str('district').isNotEmpty)
              _MetaRow(
                label: 'District',
                value: _str('district'),
                colorScheme: colorScheme,
              ),
            if (_str('tehsil').isNotEmpty)
              _MetaRow(
                label: 'Tehsil',
                value: _str('tehsil'),
                colorScheme: colorScheme,
              ),
            if (_str('villageMouza').isNotEmpty)
              _MetaRow(
                label: 'Village / Mouza',
                value: _str('villageMouza'),
                colorScheme: colorScheme,
              ),
          ],

          // ---- Registered Document Copies -----------------------------
          if (request.serviceId == registeredDocumentCopiesServiceId) ...[
            if (request.serviceSubtype.isNotEmpty)
              _MetaRow(
                label: 'Document type',
                value: registeredDocumentSubtypeLabels[
                        request.serviceSubtype] ??
                    request.serviceSubtype,
                colorScheme: colorScheme,
              ),
            if (_str('bookNumber').isNotEmpty)
              _MetaRow(
                label: 'Book No.',
                value: _str('bookNumber'),
                colorScheme: colorScheme,
              ),
            if (_str('volumeNumber').isNotEmpty)
              _MetaRow(
                label: 'Volume No.',
                value: _str('volumeNumber'),
                colorScheme: colorScheme,
              ),
            if (_str('documentNumber').isNotEmpty)
              _MetaRow(
                label: 'Document No.',
                value: _str('documentNumber'),
                colorScheme: colorScheme,
              ),
            if (_str('dated').isNotEmpty)
              _MetaRow(
                label: 'Dated',
                value: _str('dated'),
                colorScheme: colorScheme,
              ),
          ],

          // ---- High Court Certified Copies ----------------------------
          if (request.serviceId == highCourtCertifiedCopiesServiceId) ...[
            if (_str('caseNumber').isNotEmpty ||
                _str('caseYear').isNotEmpty)
              _MetaRow(
                label: 'Case No.',
                value: _highCourtFullCaseNumber(),
                colorScheme: colorScheme,
              ),
            if (_str('firstParty').isNotEmpty ||
                _str('secondParty').isNotEmpty)
              _MetaRow(
                label: 'Parties',
                value: [
                  if (_str('firstParty').isNotEmpty) _str('firstParty'),
                  if (_str('secondParty').isNotEmpty)
                    'vs. ${_str('secondParty')}',
                ].join(' '),
                colorScheme: colorScheme,
              ),
            if (_str('peshiType').isNotEmpty &&
                _str('peshiDate').isNotEmpty)
              _MetaRow(
                label: 'Peshi',
                value:
                    '${_peshiTypeLabel()} — ${_str('peshiDate')}',
                colorScheme: colorScheme,
              ),
            if (_str('district').isNotEmpty)
              _MetaRow(
                label: 'District',
                value: _str('district'),
                colorScheme: colorScheme,
              ),
          ],

          // ---- District Court Certified Copies ------------------------
          if (request.serviceId ==
              districtCourtCertifiedCopiesServiceId) ...[
            if (request.caseType.isNotEmpty)
              _MetaRow(
                label: 'Case type',
                value: request.caseType,
                colorScheme: colorScheme,
              ),
            if (request.caseStatus.isNotEmpty)
              _MetaRow(
                label: 'Case status',
                value: request.caseStatus,
                colorScheme: colorScheme,
              ),
            if (request.courtOrJurisdiction.isNotEmpty)
              _MetaRow(
                label: 'Jurisdiction',
                value: request.courtOrJurisdiction,
                colorScheme: colorScheme,
              ),
            if (request.judge.isNotEmpty)
              _MetaRow(
                label: 'Court / Judge',
                value: request.judge,
                colorScheme: colorScheme,
              ),
            if (request.caseNumber.isNotEmpty)
              _MetaRow(
                label: 'Case ID',
                value: request.caseNumber,
                colorScheme: colorScheme,
              ),
            if (request.firNumber.isNotEmpty ||
                request.firYear.isNotEmpty)
              _MetaRow(
                label: 'FIR No.',
                value: [
                  if (request.firNumber.isNotEmpty) request.firNumber,
                  if (request.firYear.isNotEmpty)
                    '/ 20${request.firYear}',
                ].join(' '),
                colorScheme: colorScheme,
              ),
            if (request.policeStation.isNotEmpty)
              _MetaRow(
                label: 'Police Station',
                value: request.policeStation,
                colorScheme: colorScheme,
              ),
            if (request.offence.isNotEmpty)
              _MetaRow(
                label: 'Offence',
                value: request.offence,
                colorScheme: colorScheme,
              ),
            if (request.dated.isNotEmpty)
              _MetaRow(
                label: 'Dated',
                value: request.dated,
                colorScheme: colorScheme,
              ),
            if (request.caseDecidedOn.isNotEmpty)
              _MetaRow(
                label: 'Decided On',
                value: request.caseDecidedOn,
                colorScheme: colorScheme,
              ),
            if (request.nextHearingDate.isNotEmpty)
              _MetaRow(
                label: 'Next Hearing',
                value: request.nextHearingDate,
                colorScheme: colorScheme,
              ),
          ],

          if (request.id != null)
            _MetaRow(
              label: 'Reference',
              value: request.id!,
              colorScheme: colorScheme,
            ),

          // ---- District Court documents-requested block ---------------
          if (documents.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Documents requested',
              style: AppTextStyles.caption.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
            for (final doc in documents)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  '• $doc',
                  style: AppTextStyles.caption.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
          ],

          // ---- High Court bulleted lists ------------------------------
          if (request.serviceId == highCourtCertifiedCopiesServiceId) ...[
            ..._bulletedBlock(
              'Justices',
              _strList('justices'),
            ),
            ..._bulletedBlock(
              'Requested copy details',
              _strList('requestedCopyDetails'),
            ),
          ],
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;
  final ColorScheme colorScheme;

  const _StatusChip({
    required this.status,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    if (status.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(
          color: colorScheme.primary.withValues(alpha: 0.25),
        ),
      ),
      child: Text(
        status,
        style: AppTextStyles.caption.copyWith(
          color: colorScheme.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  final String label;
  final String value;
  final ColorScheme colorScheme;

  const _MetaRow({
    required this.label,
    required this.value,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 108,
            child: Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.caption.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}