import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../models/scanner_document.dart';
import '../../models/scanner_document_category.dart';

/// Presentation-only library card for a single document.
///
/// Designed to be placed inside a bounded GridView cell. It uses
/// intrinsic sizing from its parent cell and does not request
/// infinite width.
///
/// The card does not access repositories or providers. It exposes
/// callbacks only.
///
/// Long-press is reserved for entering multi-select mode. In
/// selection mode, tap and long-press both raise
/// [onToggleSelection]. The card does not own selection state; the
/// provider and screen do.
///
/// Single-document actions (Favourite, Rename, Delete, Move,
/// Duplicate) are surfaced through the explicit overflow affordance
/// (`onOpenActions`) in normal mode. That affordance is hidden
/// while the card is in selection mode.
class ScannerLibraryCard extends StatelessWidget {
  const ScannerLibraryCard({
    super.key,
    required this.document,
    required this.onTap,
    this.onLongPress,
    this.onToggleFavorite,
    this.onOpenActions,
    this.isSelectionMode = false,
    this.isSelected = false,
    this.onToggleSelection,
  });

  final ScannerDocument document;
  final VoidCallback onTap;

  /// Raised on long-press. The screen uses this to enter selection
  /// mode. Null disables the gesture.
  final VoidCallback? onLongPress;

  /// Raised when the favourite star is tapped. Null makes the star a
  /// read-only indicator. Hidden in selection mode.
  final VoidCallback? onToggleFavorite;

  /// Raised when the overflow affordance is tapped. Null hides the
  /// overflow entirely. Hidden in selection mode.
  final VoidCallback? onOpenActions;

  /// When true, the card is a selection target: tap and long-press
  /// raise [onToggleSelection], the overflow and favourite star are
  /// hidden, and the selected state is rendered when [isSelected].
  final bool isSelectionMode;

  /// When true and [isSelectionMode] is true, the card renders a
  /// selected treatment.
  final bool isSelected;

  /// Raised on tap or long-press while [isSelectionMode] is true.
  final VoidCallback? onToggleSelection;

  @override
  Widget build(BuildContext context) {
    final meta = document.metadata;
    final selected = isSelectionMode && isSelected;

    return Material(
      color: selected
          ? AppColors.primary.withValues(alpha: 0.08)
          : AppColors.lightSurface,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        onTap: isSelectionMode
            ? (onToggleSelection ?? onTap)
            : onTap,
        onLongPress: isSelectionMode
            ? (onToggleSelection ?? onLongPress)
            : onLongPress,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: selected
                  ? AppColors.primary
                  : AppColors.lightBorder,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: Icon(
                      _documentIcon(document),
                      color: AppColors.accent,
                      size: AppSpacing.iconSm,
                    ),
                  ),
                  const Spacer(),
                  if (isSelectionMode)
                    _SelectionIndicator(isSelected: selected)
                  else ...[
                    _FavoriteStar(
                      isFavorite: meta.isFavorite,
                      onTap: onToggleFavorite,
                    ),
                    if (onOpenActions != null)
                      _CardOverflowButton(
                        onPressed: onOpenActions!,
                      ),
                  ],
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    meta.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.lightTextPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    _categoryLabel(meta.category),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _formatDate(meta.updatedAt),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.caption,
                    ),
                  ),
                  Text(
                    '${meta.pageCount} p.',
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static IconData _documentIcon(ScannerDocument document) {
    if (document.pdfDocument != null) {
      return Icons.picture_as_pdf_outlined;
    }
    return Icons.description_outlined;
  }

  static String _categoryLabel(ScannerDocumentCategory category) {
    switch (category) {
      case ScannerDocumentCategory.courtDocument:
        return 'Court Document';
      case ScannerDocumentCategory.legalNotice:
        return 'Legal Notice';
      case ScannerDocumentCategory.contract:
        return 'Contract';
      case ScannerDocumentCategory.cnicOrDocumentScan:
        return 'CNIC / Document Scan';
      case ScannerDocumentCategory.propertyDocument:
        return 'Property Document';
      case ScannerDocumentCategory.agreement:
        return 'Agreement';
      case ScannerDocumentCategory.application:
        return 'Application';
      case ScannerDocumentCategory.affidavit:
        return 'Affidavit';
      case ScannerDocumentCategory.judgment:
        return 'Judgment';
      case ScannerDocumentCategory.evidenceDocument:
        return 'Evidence';
      case ScannerDocumentCategory.caseFile:
        return 'Case File';
      case ScannerDocumentCategory.legalCorrespondence:
        return 'Legal Correspondence';
      case ScannerDocumentCategory.other:
        return 'Other';
    }
  }

  static const List<String> _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  static String _formatDate(DateTime date) {
    return '${date.day} ${_months[date.month - 1]} ${date.year}';
  }
}

/// Tappable favourite indicator. Renders filled/outline based on
/// [isFavorite]. When [onTap] is null the star is a read-only icon.
class _FavoriteStar extends StatelessWidget {
  const _FavoriteStar({
    required this.isFavorite,
    required this.onTap,
  });

  final bool isFavorite;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final icon = Icon(
      isFavorite ? Icons.star : Icons.star_border,
      color: isFavorite
          ? AppColors.accent
          : AppColors.lightTextSecondary,
      size: AppSpacing.iconSm,
    );

    if (onTap == null) {
      return icon;
    }

    return InkResponse(
      onTap: onTap,
      radius: AppSpacing.iconSm,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: icon,
      ),
    );
  }
}

/// Small overflow affordance. Calls [onPressed] when tapped. Kept
/// deliberately minimal: it is only an entry point for the
/// single-document action sheet, which the screen owns.
class _CardOverflowButton extends StatelessWidget {
  const _CardOverflowButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onPressed,
      radius: AppSpacing.iconSm,
      child: const Padding(
        padding: EdgeInsets.all(AppSpacing.xs),
        child: Icon(
          Icons.more_vert,
          color: AppColors.lightTextSecondary,
          size: AppSpacing.iconSm,
        ),
      ),
    );
  }
}

/// Selection affordance shown in place of the favourite star and
/// overflow button while the card is in selection mode.
///
/// Uses only the existing theme language: the primary color for
/// the selected checkmark and the secondary text color for the
/// unselected outline.
class _SelectionIndicator extends StatelessWidget {
  const _SelectionIndicator({required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Icon(
      isSelected
          ? Icons.check_circle
          : Icons.radio_button_unchecked,
      color: isSelected
          ? AppColors.primary
          : AppColors.lightTextSecondary,
      size: AppSpacing.iconMd,
    );
  }
}