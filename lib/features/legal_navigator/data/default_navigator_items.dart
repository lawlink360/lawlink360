/// ------------------------------------------------------------
/// LawLink360
/// Feature : Legal Navigator
/// File    : default_navigator_items.dart
/// Purpose : Default cards displayed in Legal Navigator.
/// ------------------------------------------------------------

import '../enums/navigator_item_type.dart';
import '../models/navigator_item_model.dart';
import 'navigator_icons.dart';

final List<NavigatorItemModel> defaultNavigatorItems = [

  NavigatorItemModel(
    type: NavigatorItemType.relevantLaws,
    title: 'Relevant Laws',
    subtitle: 'View applicable laws',
    icon: NavigatorIcons.laws,
  ),

  NavigatorItemModel(
    type: NavigatorItemType.relatedJudgments,
    title: 'Related Judgments',
    subtitle: 'Explore court decisions',
   icon: NavigatorIcons.judgments,
  ),

  NavigatorItemModel(
    type: NavigatorItemType.relatedProcedures,
    title: 'Related Procedures',
    subtitle: 'Step-by-step legal process',
    icon: NavigatorIcons.procedures,
  ),

  NavigatorItemModel(
    type: NavigatorItemType.relatedApplications,
    title: 'Related Applications',
    subtitle: 'Application templates',
   icon: NavigatorIcons.applications,
  ),

  NavigatorItemModel(
    type: NavigatorItemType.drafting,
    title: 'Drafting',
    subtitle: 'Prepare legal documents',
    icon: NavigatorIcons.drafting,
  ),

  NavigatorItemModel(
    type: NavigatorItemType.requiredDocuments,
    title: 'Required Documents',
    subtitle: 'Documents you may need',
   icon: NavigatorIcons.documents,
  ),

  NavigatorItemModel(
    type: NavigatorItemType.findLawyer,
    title: 'Find a Lawyer',
    subtitle: 'Consult legal experts',
   icon: NavigatorIcons.lawyers,
  ),

  NavigatorItemModel(
    type: NavigatorItemType.faqs,
    title: 'FAQs',
    subtitle: 'Frequently asked questions',
   icon: NavigatorIcons.faqs,
  ),

  NavigatorItemModel(
    type: NavigatorItemType.searchRelatedContent,
    title: 'Search Related Content',
    subtitle: 'Search connected legal resources',
   icon: NavigatorIcons.search,
  ),

  NavigatorItemModel(
    type: NavigatorItemType.aiLegalAssistant,
    title: 'AI Legal Assistant',
    subtitle: 'Coming Soon',
    icon: NavigatorIcons.aiAssistant,
    isEnabled: false,
  ),
];