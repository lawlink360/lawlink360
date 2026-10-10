import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
import '../providers/related_resource_provider.dart';
import '../utils/navigator_helper.dart';
import '../utils/route_helper.dart';

class LegalNavigator extends ConsumerStatefulWidget {
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
  ConsumerState<LegalNavigator> createState() => _LegalNavigatorState();
}

class _LegalNavigatorState extends ConsumerState<LegalNavigator> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    // Single source of truth for current-content filtering.
    // Uses typed enum-based filtering via NavigatorHelper so that
    // title strings are not used as the filtering key.
    final visibleByVisibility = defaultNavigatorItems
        .where((item) => item.isVisible)
        .toList();

    final items = NavigatorHelper.filterCurrentCategory(
      contentType: widget.contentType,
      items: visibleByVisibility,
    );

    // Resolve related resources for the current context.
    // Currently returns an empty list because the underlying
    // datasets do not exist yet in this phase.
    final related = ref.watch(
      relatedResourcesProvider(
        (contentType: widget.contentType, contentId: widget.contentId),
      ),
    );

    final visibleItems = expanded ? items : items.take(5).toList();

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
              onItemTap: (item) => _onItemTap(item, related),
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

    void _onItemTap(
    NavigatorItemModel item,
    List<dynamic> related,
  ) {
    // Resolve a destination route for this navigator item type.
    const routeHelper = RouteHelper();
    final route = routeHelper.resolve(item.type);

    if (route == null) {
      // Destination not implemented yet. Fail gracefully.
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        const SnackBar(
          content: Text('This section is not available yet.'),
        ),
      );
      return;
    }

    // Attempt to navigate to the named route. If the app has not
    // registered this route in its MaterialApp routes table, fall
    // back to a graceful message instead of crashing.
    try {
      Navigator.of(context).pushNamed(route);
    } on FlutterError {
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        const SnackBar(
          content: Text('This section is not available yet.'),
        ),
      );
    }
  }
}