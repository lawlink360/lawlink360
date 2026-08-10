import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Global Loading State
final appLoadingProvider = StateProvider<bool>((ref) => false);

/// Selected Bottom Navigation Index
final navigationIndexProvider = StateProvider<int>((ref) => 0);

/// Search Text
final globalSearchProvider = StateProvider<String>((ref) => '');

/// Premium Status
final premiumProvider = StateProvider<bool>((ref) => false);