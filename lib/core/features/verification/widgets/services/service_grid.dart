import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../../models/verification_service.dart';
import '../../services/verification_data_service.dart';
import '../../screens/verification_webview_screen.dart';
import 'service_card.dart';

class ServiceGrid extends StatelessWidget {
  final String institutionId;

  const ServiceGrid({
    super.key,
    required this.institutionId,
  });

  @override
  Widget build(BuildContext context) {
    final List<VerificationService> services =
        VerificationDataService.getServices(institutionId);

    if (services.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.06),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.inventory_2_outlined,
                  size: 34,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'No Services Available',
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'There are currently no verification services for this institution.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.only(
        top: AppSpacing.xs,
        bottom: AppSpacing.xl,
      ),
      physics: const BouncingScrollPhysics(),
      itemCount: services.length,
      separatorBuilder: (_, _) =>
          const SizedBox(height: AppSpacing.xs),
      itemBuilder: (context, index) {
        final service = services[index];

        return ServiceCard(
          icon: service.icon,
          color: service.color,
          title: service.title,
          description: service.description,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => VerificationWebViewScreen(
                  title: service.title,
                  url: service.websiteUrl,
                ),
              ),
            );
          },
        );
      },
    );
  }
}