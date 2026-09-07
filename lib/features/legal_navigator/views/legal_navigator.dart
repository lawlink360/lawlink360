import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';

import '../components/empty_widget.dart';
import '../components/loading_widget.dart';
import '../components/navigator_card.dart';
import '../components/navigator_header.dart';
import '../components/show_more_button.dart';
import '../data/default_navigator_items.dart';
import '../enums/content_type.dart';
import '../models/navigator_item_model.dart';

class LegalNavigator extends StatefulWidget {
  final ContentType contentType;
  final String contentId;
  final bool isLoading;

  const LegalNavigator({
    super.key,
    required this.contentType,
    required this.contentId,
    this.isLoading = false,
  });

  @override
  State<LegalNavigator> createState() => _LegalNavigatorState();
}

class _LegalNavigatorState extends State<LegalNavigator> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final List<NavigatorItemModel> items = defaultNavigatorItems
        .where((item) => item.isVisible)
        .toList();

    // Hide the resource category that represents the current content.
    switch (widget.contentType) {
      case ContentType.law:
        items.removeWhere(
          (item) => item.title == 'Relevant Laws',
        );
        break;

      case ContentType.judgment:
        items.removeWhere(
          (item) => item.title == 'Related Judgments',
        );
        break;

      case ContentType.procedure:
        items.removeWhere(
          (item) => item.title == 'Related Procedures',
        );
        break;

      case ContentType.application:
        items.removeWhere(
          (item) => item.title == 'Related Applications',
        );
        break;

      case ContentType.drafting:
        items.removeWhere(
          (item) => item.title == 'Drafting',
        );
        break;

      default:
        break;
    }

    final visibleItems = expanded
        ? items
        : items.take(5).toList();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.lightBackground,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: AppColors.lightBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const NavigatorHeader(),
          if (widget.isLoading)
            const LoadingWidget()
          else if (items.isEmpty)
            const EmptyWidget()
          else ...[
            NavigatorCard(
              items: visibleItems,
              onItemTap: (item) {
                debugPrint(item.title);
              },
            ),
            if (items.length > 5) ...[
              const SizedBox(height: AppSpacing.xs),
              Align(
                alignment: Alignment.center,
                child: ShowMoreButton(
                  expanded: expanded,
                  onPressed: () {
                    setState(() {
                      expanded = !expanded;
                    });
                  },
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}
