import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../models/case_models.dart';
import 'case_status_badge.dart';

class CaseCard extends StatelessWidget {
  final CaseModel caseItem;
  final VoidCallback? onTap;

  const CaseCard({
    super.key,
    required this.caseItem,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: AppColors.lightBorder,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        caseItem.title,
                        style: AppTextStyles.title.copyWith(
                          color: AppColors.lightTextPrimary,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    CaseStatusBadge(
                      status: caseItem.status,
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.xs),

                Text(
                  'Case No: ${caseItem.caseNumber}',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.lightTextSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                _infoRow(
                  Icons.person_outline_rounded,
                  'Client',
                  caseItem.clientName,
                ),

                const SizedBox(height: AppSpacing.sm),

                _infoRow(
                  Icons.gavel_outlined,
                  'Lawyer',
                  caseItem.lawyerName,
                ),

                const SizedBox(height: AppSpacing.sm),

                _infoRow(
                  Icons.account_balance_outlined,
                  'Court',
                  caseItem.courtName,
                ),

                const SizedBox(height: AppSpacing.md),

                Divider(
                  height: 1,
                  color: AppColors.divider,
                ),

                const SizedBox(height: AppSpacing.md),

                Row(
                  children: [
                    Expanded(
                      child: _bottomInfo(
                        Icons.calendar_today_outlined,
                        'Next Hearing',
                        '${caseItem.nextHearing.day}/${caseItem.nextHearing.month}/${caseItem.nextHearing.year}',
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: _bottomInfo(
                        Icons.update_outlined,
                        'Updated',
                        '${caseItem.lastUpdated.day}/${caseItem.lastUpdated.month}/${caseItem.lastUpdated.year}',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.07),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Icon(
            icon,
            size: 18,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: RichText(
              text: TextSpan(
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.lightTextPrimary,
                ),
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: value,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _bottomInfo(
    IconData icon,
    String title,
    String value,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: AppColors.lightTextSecondary,
          size: 18,
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.lightTextSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                value,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.lightTextPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}