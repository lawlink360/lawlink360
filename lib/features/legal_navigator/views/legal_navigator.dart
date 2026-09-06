import 'package:flutter/material.dart';

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

    List<NavigatorItemModel> items =
        defaultNavigatorItems.where((e) => e.isVisible).toList();

    // Hide current category
    switch (widget.contentType) {
      case ContentType.law:
        items.removeWhere((e) =>
            e.title == 'Relevant Laws');
        break;

      case ContentType.judgment:
        items.removeWhere((e) =>
            e.title == 'Related Judgments');
        break;

      case ContentType.procedure:
        items.removeWhere((e) =>
            e.title == 'Related Procedures');
        break;

      case ContentType.application:
        items.removeWhere((e) =>
            e.title == 'Related Applications');
        break;

      case ContentType.drafting:
        items.removeWhere((e) =>
            e.title == 'Drafting');
        break;

      default:
        break;
    }

    final visibleItems =
        expanded ? items : items.take(5).toList();

    return Column(
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

          if (items.length > 5)

            ShowMoreButton(
              expanded: expanded,
              onPressed: () {
                setState(() {
                  expanded = !expanded;
                });
              },
            ),
        ],
      ],
    );
  }
}