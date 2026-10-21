import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/client_module/copy_house/data/copy_house_request_constants.dart';
import 'package:lawlink360/core/features/client_module/copy_house/screens/mutation_copy_form_screen.dart';
import 'package:lawlink360/core/features/client_module/copy_house/screens/registered_document_copy_form_screen.dart';
import 'package:lawlink360/core/features/client_module/copy_house/screens/court_certified_copies_selection_screen.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../data/copy_house_services.dart';

class CopyHouseServiceCard extends StatelessWidget {
  final CopyHouseService service;

  const CopyHouseServiceCard({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        onTap: () => _handleTap(context),
        child: Ink(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: colorScheme.outlineVariant.withValues(alpha: 0.55),
            ),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withValues(alpha: 0.05),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: service.color.withValues(alpha: 0.11),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: service.color.withValues(alpha: 0.20),
                  ),
                ),
                child: Icon(
                  service.icon,
                  color: service.color,
                  size: 24,
                ),
              ),

              const SizedBox(width: AppSpacing.md),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.title,
                      style: AppTextStyles.body.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      service.summary,
                      style: AppTextStyles.caption.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: AppSpacing.sm),

              Icon(
                Icons.chevron_right_rounded,
                color: colorScheme.onSurface.withValues(alpha: 0.42),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// The Court Certified Copies card opens the intermediate selection
  /// screen directly. All other services keep the informational bottom
  /// sheet whose "Submit a Request" button opens the corresponding
  /// form.
  void _handleTap(BuildContext context) {
    if (service.id == districtCourtCertifiedCopiesServiceId) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const CourtCertifiedCopiesSelectionScreen(),
        ),
      );
      return;
    }
    _showServiceInfo(context);
  }

  void _showServiceInfo(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        final colorScheme = Theme.of(context).colorScheme;
        final hasForm = _hasFormFor(service.id);

        return Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            0,
            AppSpacing.lg,
            AppSpacing.lg,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: service.color.withValues(alpha: 0.11),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: service.color.withValues(alpha: 0.20),
                      ),
                    ),
                    child: Icon(
                      service.icon,
                      color: service.color,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      service.title,
                      style: AppTextStyles.title.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.md),

              Text(
                service.description,
                style: AppTextStyles.body.copyWith(
                  color: colorScheme.onSurface,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: service.color.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(
                    color: service.color.withValues(alpha: 0.20),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.schedule_rounded,
                      size: 18,
                      color: service.color,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Text(
                        hasForm
                            ? 'Submit a request and our team will '
                              'contact you regarding next steps.'
                            : 'Online requests for this service are '
                              'coming soon.',
                        style: AppTextStyles.caption.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              if (hasForm) ...[
                const SizedBox(height: AppSpacing.md),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      final builder = _formBuilderFor(service.id);
                      if (builder == null) return;
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: builder),
                      );
                    },
                    icon: const Icon(Icons.edit_document),
                    label: const Text('Submit a Request'),
                  ),
                ),
              ],

              const SizedBox(height: AppSpacing.sm),
            ],
          ),
        );
      },
    );
  }

  bool _hasFormFor(String serviceId) {
    return _formBuilderFor(serviceId) != null;
  }

  WidgetBuilder? _formBuilderFor(String serviceId) {
    switch (serviceId) {
      case districtCourtCertifiedCopiesServiceId:
        return (_) => const CourtCertifiedCopiesSelectionScreen();
      case mutationCopiesServiceId:
        return (_) => const MutationCopyFormScreen();
      case registeredDocumentCopiesServiceId:
        return (_) => const RegisteredDocumentCopyFormScreen();
      default:
        return null;
    }
  }
}