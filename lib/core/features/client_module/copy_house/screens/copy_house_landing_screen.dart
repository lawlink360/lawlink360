import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/client_module/copy_house/data/copy_house_services.dart';
import 'package:lawlink360/core/features/client_module/copy_house/screens/court_certified_copies_selection_screen.dart';
import 'package:lawlink360/core/features/client_module/copy_house/screens/mutation_copy_form_screen.dart';
import 'package:lawlink360/core/features/client_module/copy_house/screens/my_requests_placeholder_screen.dart';
import 'package:lawlink360/core/features/client_module/copy_house/screens/registered_document_copy_form_screen.dart';
import 'package:lawlink360/core/features/client_module/copy_house/widgets/copy_house_header.dart';
import 'package:lawlink360/core/features/client_module/copy_house/widgets/customer_support_center.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

/// Apply Online page — the service-category page.
///
/// Amendments 5–6 applied:
///  - Title changed to "Apply Online". Logo added at the top.
///  - Service categories rendered as square cards (Application-module
///    pattern) with unchanged service IDs and unchanged routing:
///      * Court Certified Copies → Court selection screen.
///      * Mutation Copies → informational sheet → Mutation form.
///      * Registered Document Copies → informational sheet → Form.
///  - "My Online Requests" and "Track My Online Requests" added below
///    the service grid, visually distinct.
///  - Customer Support section retained unchanged.
class CopyHouseLandingScreen extends StatelessWidget {
  const CopyHouseLandingScreen({super.key});

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
          'Apply Online',
          style: AppTextStyles.title.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.xl,
        ),
        physics: const BouncingScrollPhysics(),
        children: [
          // ---- Logo ------------------------------------------------
          Center(
            child: Image.asset(
              'assets/logos/lawlink360_transparent_logo.png',
              height: 40,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // ---- Header ----------------------------------------------
          const CopyHouseHeader(),

          const SizedBox(height: AppSpacing.lg),

          // ---- Service categories (square cards) -------------------
          Text(
            'Service Categories',
            style: AppTextStyles.title.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: copyHouseServices.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppSpacing.sm,
              mainAxisSpacing: AppSpacing.sm,
              childAspectRatio: 1.0,
            ),
            itemBuilder: (context, index) {
              final service = copyHouseServices[index];
              return _ServiceSquareCard(
                service: service,
                onTap: () => _openService(context, service.id),
              );
            },
          ),

          const SizedBox(height: AppSpacing.lg),

          // ---- Requests (Amendment 6) ------------------------------
          Text(
            'Requests',
            style: AppTextStyles.title.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _RequestOption(
            icon: Icons.receipt_long_outlined,
            title: 'My Online Requests',
            subtitle:
                'View the status of Copy House requests you have made.',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const MyRequestsPlaceholderScreen(),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _RequestOption(
            icon: Icons.track_changes_outlined,
            title: 'Track My Online Requests',
            subtitle:
                'Detailed per-request tracking is coming soon. Your '
                'current request status is shown under My Online Requests.',
            onTap: () => _showTrackingInfo(context),
          ),

          const SizedBox(height: AppSpacing.lg),

          // ---- Customer Support (retained) -------------------------
          Text(
            'Customer Support',
            style: AppTextStyles.title.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          const CustomerSupportCenter(),
        ],
      ),
    );
  }

  void _openService(BuildContext context, String serviceId) {
    if (serviceId == 'district_court_certified_copies') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const CourtCertifiedCopiesSelectionScreen(),
        ),
      );
      return;
    }
    if (serviceId == 'mutation_copies') {
      _showServiceInfoSheet(
        context,
        title: 'Mutation Copies',
        description:
            'Facilitates requests for copies of revenue mutation records.',
        onContinue: () {
          Navigator.of(context).pop();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const MutationCopyFormScreen(),
            ),
          );
        },
      );
      return;
    }
    if (serviceId == 'registered_document_copies') {
      _showServiceInfoSheet(
        context,
        title: 'Registered Document Copies',
        description:
            'Facilitates requests for copies of registered documents.',
        onContinue: () {
          Navigator.of(context).pop();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const RegisteredDocumentCopyFormScreen(),
            ),
          );
        },
      );
      return;
    }
  }

  void _showServiceInfoSheet(
    BuildContext context, {
    required String title,
    required String description,
    required VoidCallback onContinue,
  }) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        final colorScheme = Theme.of(context).colorScheme;
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
              Text(
                title,
                style: AppTextStyles.title.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                description,
                style: AppTextStyles.body.copyWith(
                  color: colorScheme.onSurface,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: onContinue,
                  icon: const Icon(Icons.edit_document),
                  label: const Text('Submit a Request'),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
          ),
        );
      },
    );
  }

  void _showTrackingInfo(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        final colorScheme = Theme.of(context).colorScheme;
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
              Text(
                'Track My Online Requests',
                style: AppTextStyles.title.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Detailed per-request tracking is not available yet. '
                'You can see each request and its current status under '
                '"My Online Requests".',
                style: AppTextStyles.body.copyWith(
                  color: colorScheme.onSurface,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            const MyRequestsPlaceholderScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.receipt_long_outlined),
                  label: const Text('Open My Online Requests'),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
          ),
        );
      },
    );
  }
}

// -----------------------------------------------------------------------------
// Service square card — matches ApplicationCategoryCard layout.
// -----------------------------------------------------------------------------

class _ServiceSquareCard extends StatelessWidget {
  final CopyHouseService service;
  final VoidCallback onTap;

  const _ServiceSquareCard({
    required this.service,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: service.color.withValues(alpha: 0.11),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: service.color.withValues(alpha: 0.16),
                          ),
                        ),
                        child: Icon(
                          service.icon,
                          color: service.color,
                          size: 25,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      service.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 12,
                    color: colorScheme.onSurface.withValues(alpha: 0.42),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      'Open',
                      style: AppTextStyles.caption.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Request option — wide row for My Online Requests and Track.
// -----------------------------------------------------------------------------

class _RequestOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _RequestOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: colorScheme.primary.withValues(alpha: 0.30),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.10),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: colorScheme.primary,
                  size: 22,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.body.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: AppTextStyles.caption.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
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
}