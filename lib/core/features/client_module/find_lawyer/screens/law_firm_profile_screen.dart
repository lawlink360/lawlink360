import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import 'package:lawlink360/core/features/client_module/find_lawyer/models/law_firm_model.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/models/lawyer_model.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/providers/lawyer_provider.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/screens/book_appointment_screen.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/widgets/lawyer_card.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class LawFirmProfileScreen extends ConsumerStatefulWidget {
  final LawFirm firm;

  const LawFirmProfileScreen({
    super.key,
    required this.firm,
  });

  @override
  ConsumerState<LawFirmProfileScreen> createState() =>
      _LawFirmProfileScreenState();
}

class _LawFirmProfileScreenState
    extends ConsumerState<LawFirmProfileScreen> {
  bool _isFavorite = false;

  void _shareFirm() {
    Share.share(
      '${widget.firm.name}\n'
      '${widget.firm.location}\n'
      'LawLink360 - Trusted Digital Legal Partner',
    );
  }

  List<Lawyer> _firmLawyers(List<Lawyer> lawyers) {
    return lawyers
        .where(
          (lawyer) => lawyer.lawFirmId == widget.firm.id,
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final lawyersAsync = ref.watch(lawyerDirectoryProvider);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Law Firm Profile',
          style: AppTextStyles.title.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: colorScheme.onSurface,
          ),
          tooltip: 'Back',
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });
            },
            icon: Icon(
              _isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: _isFavorite
                  ? Colors.red
                  : colorScheme.onSurface,
            ),
            tooltip: 'Favorite',
          ),
          IconButton(
            onPressed: _shareFirm,
            icon: Icon(
              Icons.share_rounded,
              color: colorScheme.onSurface,
            ),
            tooltip: 'Share',
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.xxl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFirmHeader(context),

              const SizedBox(height: AppSpacing.xl),

              _buildAvailabilityAndFees(context),

              const SizedBox(height: AppSpacing.xl),

              Text(
                'About the Firm',
                style: AppTextStyles.headline.copyWith(
                  color: colorScheme.onSurface,
                  fontSize: 21,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),

              Text(
                widget.firm.description,
                style: AppTextStyles.body.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.55,
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              Text(
                'Practice Areas',
                style: AppTextStyles.headline.copyWith(
                  color: colorScheme.onSurface,
                  fontSize: 21,
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: widget.firm.practiceAreas
                    .map(
                      (area) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.sm,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest
                              .withValues(alpha: 0.65),
                          borderRadius:
                              BorderRadius.circular(AppRadius.pill),
                        ),
                        child: Text(
                          area,
                          style: AppTextStyles.caption.copyWith(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),

              const SizedBox(height: AppSpacing.xl),

              Text(
                'Our Lawyers',
                style: AppTextStyles.headline.copyWith(
                  color: colorScheme.onSurface,
                  fontSize: 21,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),

              Text(
                'Meet the legal professionals associated with this firm.',
                style: AppTextStyles.caption.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              lawyersAsync.when(
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.xl),
                    child: CircularProgressIndicator(),
                  ),
                ),
                error: (error, stackTrace) => _buildLawyerMessage(
                  context,
                  'Unable to load lawyers at the moment.',
                ),
                data: (lawyers) {
                  final firmLawyers = _firmLawyers(lawyers);

                  if (firmLawyers.isEmpty) {
                    return _buildLawyerMessage(
                      context,
                      'No lawyers are currently associated with this firm.',
                    );
                  }

                  return Column(
                    children: firmLawyers
                        .map(
                          (lawyer) => Padding(
                            padding: const EdgeInsets.only(
                              bottom: AppSpacing.lg,
                            ),
                            child: LawyerCard(
                              lawyer: lawyer,
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ),

              const SizedBox(height: AppSpacing.sm),

              lawyersAsync.when(
                data: (lawyers) {
                  final firmLawyers = _firmLawyers(lawyers);

                  if (firmLawyers.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return SizedBox(
                    width: double.infinity,
                    height: AppSpacing.buttonHeight,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BookAppointmentScreen(
                              lawyer: firmLawyers.first,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.calendar_month_rounded,
                      ),
                      label: const Text('Book Appointment'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppRadius.md),
                        ),
                      ),
                    ),
                  );
                },
                loading: () => const SizedBox.shrink(),
                error: (error, stackTrace) =>
                    const SizedBox.shrink(),
              ),

              const SizedBox(height: AppSpacing.xxl),

              Center(
                child: Text(
                  'LawLink360 • Trusted Digital Legal Partner',
                  style: AppTextStyles.caption.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFirmHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(
          color: widget.firm.hasActivePromotion
              ? AppColors.accent.withValues(alpha: 0.55)
              : colorScheme.outline.withValues(alpha: 0.35),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: Theme.of(context).brightness == Brightness.dark
                  ? 0.20
                  : 0.06,
            ),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(AppRadius.xl),
            ),
            child: Icon(
              Icons.business_rounded,
              color: colorScheme.primary,
              size: 38,
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  widget.firm.name,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.title.copyWith(
                    color: colorScheme.onSurface,
                    fontSize: 21,
                  ),
                ),
              ),
              if (widget.firm.verified) ...[
                const SizedBox(width: AppSpacing.xs),
                const Icon(
                  Icons.verified_rounded,
                  color: AppColors.success,
                  size: 21,
                ),
              ],
            ],
          ),

          const SizedBox(height: AppSpacing.xs),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on_rounded,
                size: 16,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: AppSpacing.xs),
              Flexible(
                child: Text(
                  widget.firm.location,
                  style: AppTextStyles.caption.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.md),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star_rounded,
                color: AppColors.accent,
                size: 18,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                widget.firm.rating.toStringAsFixed(1),
                style: AppTextStyles.body.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                '• ${widget.firm.lawyersCount} Lawyers',
                style: AppTextStyles.caption.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),

          if (widget.firm.hasActivePromotion) ...[
            const SizedBox(height: AppSpacing.md),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.12),
                borderRadius:
                    BorderRadius.circular(AppRadius.pill),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.star_rounded,
                    color: AppColors.accent,
                    size: 17,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    'Featured',
                    style: AppTextStyles.caption.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAvailabilityAndFees(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Availability & Fees',
            style: AppTextStyles.headline.copyWith(
              color: colorScheme.onSurface,
              fontSize: 21,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Divider(
            color: colorScheme.outline.withValues(alpha: 0.20),
          ),
          const SizedBox(height: AppSpacing.md),

          Row(
            children: [
              Expanded(
                child: _FirmInfoItem(
                  icon: widget.firm.isOnline
                      ? Icons.check_circle_rounded
                      : Icons.schedule_rounded,
                  title: widget.firm.isOnline
                      ? 'Available Today'
                      : 'Currently Offline',
                  value: widget.firm.isOnline
                      ? 'Online consultation available'
                      : 'Appointment required',
                  iconColor: widget.firm.isOnline
                      ? AppColors.success
                      : colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _FirmInfoItem(
                  icon: Icons.payments_rounded,
                  title: 'Consultation Fee',
                  value: widget.firm.consultationFee > 0
                      ? 'PKR ${widget.firm.consultationFee.toStringAsFixed(0)}'
                      : 'Contact firm',
                  iconColor: AppColors.accent,
                ),
              ),
            ],
          ),

          if (widget.firm.specializationSummary.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.lg),
            _FirmInfoItem(
              icon: Icons.gavel_rounded,
              title: 'Specialization',
              value: widget.firm.specializationSummary,
              iconColor: colorScheme.primary,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLawyerMessage(
    BuildContext context,
    String message,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.lg,
      ),
      child: Text(
        message,
        style: AppTextStyles.body.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _FirmInfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color iconColor;

  const _FirmInfoItem({
    required this.icon,
    required this.title,
    required this.value,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: iconColor,
          size: 22,
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.caption.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: AppTextStyles.body.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}