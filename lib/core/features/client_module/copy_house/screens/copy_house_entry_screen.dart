import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/client_module/copy_house/screens/copy_house_landing_screen.dart';
import 'package:lawlink360/core/features/client_module/copy_house/screens/my_requests_placeholder_screen.dart';
import 'package:lawlink360/core/features/client_module/copy_house/screens/payment_chart_selection_screen.dart';
import 'package:lawlink360/core/features/client_module/copy_house/screens/representative_contact_screen.dart';
import 'package:lawlink360/core/features/client_module/copy_house/widgets/copy_house_header.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

/// Copy House front door.
///
/// Amendments 1–4 applied:
///  - LawLink360 logo centered above the Copy House header.
///  - Apply Online and Apply Through a Representative as square cards.
///  - Important Notice styled to match the Application module's
///    important-notice widget. Duplicate Payment Chart button inside
///    the notice removed.
///  - Customer Support shortcut removed; My Requests moved above
///    Payment Chart as a full-width row.
class CopyHouseEntryScreen extends StatelessWidget {
  const CopyHouseEntryScreen({super.key});

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
          'Copy House',
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
          // ---- LawLink360 logo ----------------------------------------
          Center(
            child: Image.asset(
              'assets/logos/lawlink360_transparent_logo.png',
              height: 40,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // ---- Copy House brand header --------------------------------
          const CopyHouseHeader(),

          const SizedBox(height: AppSpacing.lg),

          // ---- Square cards: Apply Online / Apply Through a Rep ------
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: AppSpacing.sm,
            mainAxisSpacing: AppSpacing.sm,
            childAspectRatio: 1.0,
            children: [
              _SquareOptionCard(
                icon: Icons.app_registration_rounded,
                title: 'Apply Online',
                subtitle:
                    'Choose a service and complete the relevant form.',
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const CopyHouseLandingScreen(),
                  ),
                ),
              ),
              _SquareOptionCard(
                icon: Icons.support_agent_rounded,
                title: 'Apply Through a Representative',
                subtitle: 'Request assistance by WhatsApp or phone call.',
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const RepresentativeContactScreen(),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.md),

          // ---- My Requests (Amendment 4) ------------------------------
          _WideRow(
            icon: Icons.receipt_long_outlined,
            title: 'My Requests',
            subtitle:
                'View the status of Copy House requests you have made.',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const MyRequestsPlaceholderScreen(),
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.sm),

          // ---- Payment Chart ------------------------------------------
          _WideRow(
            icon: Icons.price_change_outlined,
            title: 'Payment Chart',
            subtitle:
                'View the approved fee schedules before submitting a '
                'request.',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const PaymentChartSelectionScreen(),
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // ---- Important Notice (Amendment 3) -------------------------
          const _ImportantNoticeCard(),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Square card — modeled on ApplicationCategoryCard.
// -----------------------------------------------------------------------------

class _SquareOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SquareOptionCard({
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
                          color: colorScheme.primary
                              .withValues(alpha: 0.11),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: colorScheme.primary
                                .withValues(alpha: 0.16),
                          ),
                        ),
                        child: Icon(
                          icon,
                          color: colorScheme.primary,
                          size: 25,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      title,
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
              Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: AppTextStyles.caption.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Wide row card — for My Requests and Payment Chart.
// -----------------------------------------------------------------------------

class _WideRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _WideRow({
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
              color: colorScheme.outlineVariant.withValues(alpha: 0.55),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.11),
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

// -----------------------------------------------------------------------------
// Important Notice card (Amendment 3).
//
// Styled to match the Application module's important-notice widget:
// tinted primary background, primary border, info icon in the corner,
// readable body text. No action button (duplicate Payment Chart
// removed). Content preserved exactly.
// -----------------------------------------------------------------------------

class _ImportantNoticeCard extends StatelessWidget {
  const _ImportantNoticeCard();

  static const List<String> _points = <String>[
    'Pay the applicable initial processing and platform fees in '
        'advance using the official payment methods provided through '
        'the app.',
    'After the request information is checked and the availability of '
        'the requested copy is assessed, you will be notified through '
        'the app and by a support team representative.',
    'You will receive the applicable service charges and a quotation '
        'for confirmation.',
    'After approving the quotation, 50% of the confirmed service '
        'charges is payable in advance.',
    'The remaining 50% must be paid before dispatch or delivery.',
    'Estimated processing time does not include delivery time.',
    'All payments must use official payment methods provided through '
        'the app. Payments outside the app will not be recognized as '
        'valid Copy House payments.',
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: colorScheme.primary.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 20,
                color: colorScheme.primary,
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  'Important Notice — Procedure and Payment',
                  style: AppTextStyles.body.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          for (var i = 0; i < _points.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      _points[i],
                      style: AppTextStyles.bodySmall.copyWith(
                        color: colorScheme.onSurface,
                        height: 1.4,
                      ),
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