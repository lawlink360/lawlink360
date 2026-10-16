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
import '../enums/navigator_item_type.dart';
import '../models/navigator_item_model.dart';
import '../providers/related_resource_provider.dart';
import '../screens/resource_results_screen.dart';
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
    final visibleByVisibility = defaultNavigatorItems
        .where((item) => item.isVisible)
        .toList();

    final items = NavigatorHelper.filterCurrentCategory(
      contentType: widget.contentType,
      items: visibleByVisibility,
    );

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
    // ----------------------------------------------------------
    // Procedure-aware results path for the Related Procedures tile.
    // ----------------------------------------------------------
    if (item.type == NavigatorItemType.relatedProcedures) {
      final procedureId = widget.contentId.trim();

      if (procedureId.isNotEmpty) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ResourceResultsScreen(
              title: 'Related Procedures',
              procedureId: procedureId,
              type: ResourceResultsType.relatedProcedures,
            ),
          ),
        );
        return;
      }

      // Fall through to the named-route flow when the widget was
      // not given a procedure id.
    }

    // ----------------------------------------------------------
    // Procedure-aware results path for the Relevant Applications
    // tile. The resolver returns `unavailable` today because no
    // reliable procedure-to-template mapping exists. The tile
    // does not fall back to the general Application home screen.
    // ----------------------------------------------------------
    if (item.type == NavigatorItemType.relatedApplications) {
      final procedureId = widget.contentId.trim();

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ResourceResultsScreen(
            title: 'Relevant Applications',
            procedureId: procedureId,
            type: ResourceResultsType.relatedApplications,
          ),
        ),
      );
      return;
    }

    // ----------------------------------------------------------
    // Procedure-aware results path for the Required Documents tile.
    // Uses the current procedure's `requiredDocuments` list via
    // the shared results screen. Does not fall through to the
    // `/documents` route.
    // ----------------------------------------------------------
    if (item.type == NavigatorItemType.requiredDocuments) {
      final procedureId = widget.contentId.trim();

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ResourceResultsScreen(
            title: 'Required Documents',
            procedureId: procedureId,
            type: ResourceResultsType.requiredDocuments,
          ),
        ),
      );
      return;
    }

    // ----------------------------------------------------------
    // Existing named-route flow for every other tile.
    // ----------------------------------------------------------
    const routeHelper = RouteHelper();
    final route = routeHelper.resolve(item.type);

    if (route == null) {
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        const SnackBar(
          content: Text('This section is not available yet.'),
        ),
      );
      return;
    }

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