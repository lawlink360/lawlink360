import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/client_module/procedure_guide/screens/procedure_detail_screen.dart';
import 'package:lawlink360/core/features/client_module/procedure_guide/widgets/procedure_card.dart';
import 'package:lawlink360/core/features/client_module/procedure_guide/widgets/required_documents_card.dart';
import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../components/empty_widget.dart';
import '../providers/related_resource_provider.dart';
import '../services/related_resource_service.dart';

/// The resource type this results screen should resolve.
///
/// Kept as a small enum rather than a generic framework. Only the
/// values actually used by the Legal Navigator are declared.
enum ResourceResultsType {
  relatedProcedures,
  relatedApplications,
  requiredDocuments,
}

/// Shared procedure-aware resource results screen for the
/// Legal Navigator.
///
/// The screen resolves one resource type for one procedure id.
/// It is intentionally kept small: no list virtualization
/// framework, no cross-type mixing. Three types are supported
/// today:
///
/// * [ResourceResultsType.relatedProcedures] – real list, category-based.
/// * [ResourceResultsType.relatedApplications] – always unavailable today,
///   because no reliable procedure-to-template mapping exists.
/// * [ResourceResultsType.requiredDocuments] – the procedure's own
///   `requiredDocuments` list, from the procedure data.
class ResourceResultsScreen extends ConsumerWidget {
  /// App bar title, e.g. "Related Procedures", "Relevant Applications",
  /// or "Required Documents".
  final String title;

  /// The procedure the user is currently viewing.
  final String procedureId;

  /// Which resource type to resolve.
  final ResourceResultsType type;

  const ResourceResultsScreen({
    super.key,
    required this.title,
    required this.procedureId,
    required this.type,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Widget body = switch (type) {
      ResourceResultsType.relatedProcedures =>
        _buildProceduresBody(ref),
      ResourceResultsType.relatedApplications =>
        _buildApplicationsBody(ref),
      ResourceResultsType.requiredDocuments =>
        _buildDocumentsBody(ref),
    };

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.title.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: body,
    );
  }

  // ============================================================
  // Related Procedures / Related Applications
  // ============================================================

  Widget _buildProceduresBody(WidgetRef ref) {
    final result = ref.watch(relatedProceduresProvider(procedureId));
    return _buildProceduresResult(result);
  }

  Widget _buildApplicationsBody(WidgetRef ref) {
    final result = ref.watch(relatedApplicationsProvider(procedureId));
    return _buildProceduresResult(result);
  }

  Widget _buildProceduresResult(RelatedProceduresResult result) {
    switch (result.status) {
      case RelatedResourceStatus.available:
        return _buildProcedureList(result);

      case RelatedResourceStatus.empty:
        return const EmptyWidget(
          message: 'No related procedures found for this procedure yet.',
        );

      case RelatedResourceStatus.unavailable:
        return EmptyWidget(
          message: result.message ??
              'This information is being updated. Please check back later.',
        );

      case RelatedResourceStatus.error:
        return EmptyWidget(
          message: result.message ??
              "We couldn't load this information. Please try again.",
        );
    }
  }

  Widget _buildProcedureList(RelatedProceduresResult result) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: result.items.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, index) {
        final procedure = result.items[index];

        return ProcedureCard(
          title: procedure.title,
          overview: procedure.overview,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProcedureDetailScreen(
                  procedure: procedure,
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ============================================================
  // Required Documents
  // ============================================================

  Widget _buildDocumentsBody(WidgetRef ref) {
    final result = ref.watch(relatedDocumentsProvider(procedureId));
    return _buildDocumentsResult(result);
  }

  Widget _buildDocumentsResult(RelatedDocumentsResult result) {
    switch (result.status) {
      case RelatedResourceStatus.available:
        return _buildDocumentList(result);

      case RelatedResourceStatus.empty:
        return const EmptyWidget(
          message: 'No required documents are listed for this procedure yet.',
        );

      case RelatedResourceStatus.unavailable:
        return EmptyWidget(
          message: result.message ??
              'This information is being updated. Please check back later.',
        );

      case RelatedResourceStatus.error:
        return EmptyWidget(
          message: result.message ??
              "We couldn't load this information. Please try again.",
        );
    }
  }

  Widget _buildDocumentList(RelatedDocumentsResult result) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: RequiredDocumentsCard(
        documents: result.documents,
      ),
    );
  }
}