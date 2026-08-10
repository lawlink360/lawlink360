/// ------------------------------------------------------------
/// LawLink360
/// Feature : Legal Navigator
/// File    : navigator_item_model.dart
/// Purpose : Represents a single Legal Navigator resource card.
/// ------------------------------------------------------------

import 'package:flutter/material.dart';
import '../enums/navigator_item_type.dart';

class NavigatorItemModel {
  final NavigatorItemType type;
  final String title;
  final String subtitle;
  final IconData icon;
  final int count;
  final bool isVisible;
  final bool isEnabled;

  const NavigatorItemModel({
    required this.type,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.count = 0,
    this.isVisible = true,
    this.isEnabled = true,
  });

  NavigatorItemModel copyWith({
    NavigatorItemType? type,
    String? title,
    String? subtitle,
    IconData? icon,
    int? count,
    bool? isVisible,
    bool? isEnabled,
  }) {
    return NavigatorItemModel(
      type: type ?? this.type,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      icon: icon ?? this.icon,
      count: count ?? this.count,
      isVisible: isVisible ?? this.isVisible,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}