import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import 'package:lawlink360/core/features/client_module/find_lawyer/models/lawyer_model.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/providers/recently_viewed_provider.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/screens/book_appointment_screen.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/screens/chat_screen.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/screens/lawyer_profile_screen.dart';
import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class LawyerCard extends ConsumerStatefulWidget {
  final Lawyer lawyer;

  const LawyerCard({
    super.key,
    required this.lawyer,
  });

  @override
  ConsumerState<LawyerCard> createState() => _LawyerCardState();
}

class _LawyerCardState extends ConsumerState<LawyerCard> {
  bool _isFavorite = false;

  Lawyer get lawyer => widget.lawyer;

  void _recordView() {
    ref.read(recentlyViewedProvider.notifier).add(lawyer);
  }

  void _openProfile() {
    _recordView();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LawyerProfileScreen(
          lawyer: lawyer,
        ),
      ),
    );
  }

  void _openChat() {
    _recordView();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ChatScreen(),
      ),
    );
  }

  void _bookAppointment() {
  _recordView();

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => BookAppointmentScreen(
        lawyer: lawyer,
      ),
    ),
  );
}

  Future<void> _shareLawyer() async {
    final feeText = lawyer.consultationFee > 0
        ? 'Consultation fee: Rs. ${lawyer.consultationFee.toStringAsFixed(0)}'
        : 'Consultation fee: Contact lawyer';

    final specialization = lawyer.specializationSummary.trim().isNotEmpty
        ? lawyer.specializationSummary.trim()
        : lawyer.speciality;

    final message = '''
Lawyer on LawLink360

${lawyer.name}
${lawyer.speciality}

$specialization

${lawyer.location}
${lawyer.experience} years experience
Rating: ${lawyer.rating.toStringAsFixed(1)}
$feeText

Find and connect with this lawyer through LawLink360.
''';

    await Share.share(message.trim());
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 1400),
        content: Text(
          _isFavorite
              ? 'Lawyer saved to favorites'
              : 'Lawyer removed from favorites',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final specialization = lawyer.specializationSummary.trim().isNotEmpty
        ? lawyer.specializationSummary.trim()
        : lawyer.speciality;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(
          color: lawyer.hasActivePromotion
              ? AppColors.accent.withValues(alpha: 0.55)
              : colorScheme.outline.withValues(alpha: 0.45),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: isDark ? 0.20 : 0.06,
            ),
            blurRadius: 16,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            lawyer.name,
                            style: AppTextStyles.title.copyWith(
                              color: colorScheme.onSurface,
                              fontSize: 17,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (lawyer.verified) ...[
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
                    Text(
                      lawyer.speciality,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              IconButton(
                onPressed: _toggleFavorite,
                visualDensity: VisualDensity.compact,
                icon: Icon(
                  _isFavorite
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  color: _isFavorite
                      ? Colors.redAccent
                      : colorScheme.onSurfaceVariant,
                ),
                tooltip: _isFavorite
                    ? 'Remove from favorites'
                    : 'Save lawyer',
              ),
              IconButton(
                onPressed: _shareLawyer,
                visualDensity: VisualDensity.compact,
                icon: Icon(
                  Icons.share_outlined,
                  color: colorScheme.onSurfaceVariant,
                ),
                tooltip: 'Share lawyer',
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            specialization,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodySmall.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.45,
            ),
          ),
          if (lawyer.hasActivePromotion) ...[
            const SizedBox(height: AppSpacing.sm),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppRadius.pill),
                border: Border.all(
                  color: AppColors.accent.withValues(alpha: 0.35),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.star_rounded,
                    color: AppColors.accent,
                    size: 16,
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
          const SizedBox(height: AppSpacing.md),
          Divider(
            color: colorScheme.outline.withValues(alpha: 0.45),
            height: 1,
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: _DetailItem(
                  icon: Icons.workspace_premium_rounded,
                  label: '${lawyer.experience} Years',
                  colorScheme: colorScheme,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _DetailItem(
                  icon: Icons.location_on_outlined,
                  label: lawyer.location,
                  colorScheme: colorScheme,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Icon(
                Icons.star_rounded,
                color: AppColors.accent,
                size: 18,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                '${lawyer.rating.toStringAsFixed(1)} rating',
                style: AppTextStyles.bodySmall.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _FeeRow(
            fee: lawyer.consultationFee,
            colorScheme: colorScheme,
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Icon(
                lawyer.isOnline
                    ? Icons.circle
                    : Icons.schedule_outlined,
                color: lawyer.isOnline
                    ? AppColors.success
                    : colorScheme.onSurfaceVariant,
                size: 11,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                lawyer.isOnline ? 'Available now' : 'Currently unavailable',
                style: AppTextStyles.caption.copyWith(
                  color: lawyer.isOnline
                      ? AppColors.success
                      : colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              if (lawyer.isOnline) ...[
                Icon(
                  Icons.wifi_rounded,
                  color: AppColors.success,
                  size: 17,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  'Online',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.success,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: AppSpacing.buttonHeight,
                  child: OutlinedButton.icon(
                    onPressed: _openProfile,
                    icon: const Icon(
                      Icons.person_outline_rounded,
                      size: 19,
                    ),
                    label: const Text('Profile'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colorScheme.primary,
                      side: BorderSide(
                        color: colorScheme.primary.withValues(alpha: 0.55),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: SizedBox(
                  height: AppSpacing.buttonHeight,
                  child: OutlinedButton.icon(
                    onPressed: _openChat,
                    icon: const Icon(
                      Icons.chat_bubble_outline_rounded,
                      size: 18,
                    ),
                    label: const Text('Chat'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colorScheme.primary,
                      side: BorderSide(
                        color: colorScheme.primary.withValues(alpha: 0.55),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            width: double.infinity,
            height: AppSpacing.buttonHeight + 4,
            child: ElevatedButton.icon(
              onPressed: _bookAppointment,
              icon: const Icon(
                Icons.calendar_month_outlined,
                size: 20,
              ),
              label: const Text('Book Appointment'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: AppColors.primary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final ColorScheme colorScheme;

  const _DetailItem({
    required this.icon,
    required this.label,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.accent,
          size: 18,
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _FeeRow extends StatelessWidget {
  final double fee;
  final ColorScheme colorScheme;

  const _FeeRow({
    required this.fee,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final feeText = fee > 0
        ? 'Rs. ${fee.toStringAsFixed(0)}'
        : 'Fee on request';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: colorScheme.primary.withValues(alpha: 0.16),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.payments_outlined,
            color: colorScheme.primary,
            size: 19,
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            'Consultation Fee',
            style: AppTextStyles.bodySmall.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Text(
            feeText,
            style: AppTextStyles.bodySmall.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}