import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class LawyerReviewCard extends StatefulWidget {
  const LawyerReviewCard({
    super.key,
  });

  @override
  State<LawyerReviewCard> createState() =>
      _LawyerReviewCardState();
}

class _LawyerReviewCardState
    extends State<LawyerReviewCard> {
  int _selectedRating = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(
          AppRadius.xl,
        ),
        border: Border.all(
          color: colorScheme.outline.withValues(
            alpha: 0.45,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: isDark ? 0.20 : 0.06,
            ),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Client Reviews',
                  style: AppTextStyles.title.copyWith(
                    color: colorScheme.onSurface,
                    fontSize: 19,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  _showWriteReviewDialog(context);
                },
                icon: const Icon(
                  Icons.rate_review_outlined,
                  size: 18,
                ),
                label: const Text('Write Review'),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          _review(
            context,
            'Muhammad Ali',
            'Excellent lawyer. Very professional and handled my criminal case successfully.',
            '5.0',
          ),

          Divider(
            height: AppSpacing.xxl,
            color: colorScheme.outline.withValues(
              alpha: 0.45,
            ),
          ),

          _review(
            context,
            'Ayesha Khan',
            'Highly recommended. Very responsive and guided me throughout the legal process.',
            '4.9',
          ),
        ],
      ),
    );
  }

  Widget _review(
    BuildContext context,
    String name,
    String review,
    String rating,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.accent,
          child: Icon(
            Icons.person_rounded,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      name,
                      style: AppTextStyles.body.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    width: AppSpacing.xs,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: AppColors.accent,
                        size: 16,
                      ),
                      const SizedBox(
                        width: AppSpacing.xs,
                      ),
                      Text(
                        rating,
                        style:
                            AppTextStyles.caption.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: AppSpacing.xs,
              ),
              Text(
                review,
                style:
                    AppTextStyles.bodySmall.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showWriteReviewDialog(
    BuildContext context,
  ) {
    _selectedRating = 0;

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (
            context,
            setDialogState,
          ) {
            final colorScheme =
                Theme.of(context).colorScheme;

            return AlertDialog(
              title: const Text(
                'Write a Review',
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'How would you rate this lawyer?',
                    style:
                        AppTextStyles.bodySmall.copyWith(
                      color:
                          colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: AppSpacing.md,
                  ),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (index) {
                        final star =
                            index + 1;

                        return IconButton(
                          onPressed: () {
                            setDialogState(() {
                              _selectedRating =
                                  star;
                            });
                          },
                          icon: Icon(
                            star <=
                                    _selectedRating
                                ? Icons.star_rounded
                                : Icons
                                    .star_border_rounded,
                            color:
                                AppColors.accent,
                            size: 30,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: AppSpacing.sm,
                  ),
                  const TextField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText:
                          'Share your experience...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                      dialogContext,
                    );
                  },
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed:
                      _selectedRating == 0
                          ? null
                          : () {
                              Navigator.pop(
                                dialogContext,
                              );

                              ScaffoldMessenger
                                  .of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Review submitted successfully',
                                    ),
                                    duration:
                                        Duration(
                                      seconds: 2,
                                    ),
                                  ),
                                );
                            },
                  child: const Text(
                    'Submit',
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
