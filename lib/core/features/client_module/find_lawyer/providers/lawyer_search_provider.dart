import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/lawyer_model.dart';

/// Search and filter state for the Find Lawyer directory.
class LawyerSearchState {
  final String searchQuery;
  final String selectedPracticeArea;
  final String selectedLocation;

  const LawyerSearchState({
    this.searchQuery = '',
    this.selectedPracticeArea = 'All',
    this.selectedLocation = 'All',
  });

  LawyerSearchState copyWith({
    String? searchQuery,
    String? selectedPracticeArea,
    String? selectedLocation,
  }) {
    return LawyerSearchState(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedPracticeArea:
          selectedPracticeArea ?? this.selectedPracticeArea,
      selectedLocation: selectedLocation ?? this.selectedLocation,
    );
  }
}

/// Controls search and filtering for the lawyer directory.
///
/// This provider is intentionally Firebase-independent.
/// It only filters the Lawyer objects supplied by the directory provider.
class LawyerSearchNotifier extends Notifier<LawyerSearchState> {
  static const List<String> practiceAreas = [
    'Civil Law',
    'Criminal Law',
    'Family & Guardian',
    'Corporate & Commercial Law',
    'Company & Firm Registration',
    'Tax & FBR',
    'Labour & Employment',
    'Immigration Law',
    'Banking & Finance',
    'Constitutional Law',
    'Narcotics',
    'NAB & FIA',
    'Consumer Protection',
    'Cyber Crime & Harassment',
    'Medical & Drugs',
    'BOR / Revenue',
    'Environmental Law',
    'Intellectual Property',
    'Alternative Dispute Resolution (ADR)',
  ];

  @override
  LawyerSearchState build() {
    return const LawyerSearchState();
  }

  void setSearchQuery(String query) {
    state = state.copyWith(
      searchQuery: query,
    );
  }

  void setPracticeArea(String practiceArea) {
    state = state.copyWith(
      selectedPracticeArea: practiceArea,
    );
  }

  void setLocation(String location) {
    state = state.copyWith(
      selectedLocation: location,
    );
  }

  void clearFilters() {
    state = state.copyWith(
      searchQuery: '',
      selectedPracticeArea: 'All',
      selectedLocation: 'All',
    );
  }

  List<Lawyer> filterLawyers(List<Lawyer> lawyers) {
    final query = _normalize(state.searchQuery);
    final location = _normalize(state.selectedLocation);

    return lawyers.where((lawyer) {
      final name = _normalize(lawyer.name);
      final speciality = _normalize(lawyer.speciality);
      final lawyerLocation = _normalize(lawyer.location);

      final matchesSearch =
          query.isEmpty ||
          name.contains(query) ||
          speciality.contains(query) ||
          lawyerLocation.contains(query);

      final matchesPracticeArea =
          state.selectedPracticeArea == 'All' ||
          matchesPracticeAreaForLawyer(
            lawyer,
            state.selectedPracticeArea,
          );

      final matchesLocation =
          location == 'all' ||
          lawyerLocation == location;

      return matchesSearch &&
          matchesPracticeArea &&
          matchesLocation;
    }).toList();
  }

  /// Returns the canonical practice area matching a user's search.
  ///
  /// Exact matches are preferred, followed by partial matches.
  String? findMatchingPracticeArea(String query) {
    final normalizedQuery = _normalize(query);

    if (normalizedQuery.isEmpty) {
      return null;
    }

    for (final practiceArea in practiceAreas) {
      if (_normalize(practiceArea) == normalizedQuery) {
        return practiceArea;
      }
    }

    for (final practiceArea in practiceAreas) {
      if (_normalize(practiceArea).contains(normalizedQuery)) {
        return practiceArea;
      }
    }

    return null;
  }

  bool matchesPracticeAreaForLawyer(
    Lawyer lawyer,
    String practiceArea,
  ) {
    final speciality = _normalize(lawyer.speciality);
    final keywords = _keywordsForPracticeArea(practiceArea);

    if (keywords.isEmpty) {
      return false;
    }

    return keywords.any(
      (keyword) => speciality.contains(
        _normalize(keyword),
      ),
    );
  }

  int countForPracticeArea(
    List<Lawyer> lawyers,
    String practiceArea,
  ) {
    return lawyers
        .where(
          (lawyer) => matchesPracticeAreaForLawyer(
            lawyer,
            practiceArea,
          ),
        )
        .length;
  }

  List<String> _keywordsForPracticeArea(
    String practiceArea,
  ) {
    switch (_normalize(practiceArea)) {
      case 'civil law':
        return ['civil'];

      case 'criminal law':
        return ['criminal'];

      case 'family & guardian':
        return [
          'family',
          'guardian',
          'guardianship',
        ];

      case 'corporate & commercial law':
        return [
          'corporate',
          'commercial',
        ];

      case 'company & firm registration':
        return [
          'company registration',
          'firm registration',
          'company',
          'firm',
          'registration',
        ];

      case 'tax & fbr':
        return [
          'tax',
          'fbr',
        ];

      case 'labour & employment':
        return [
          'labour',
          'labor',
          'employment',
        ];

      case 'immigration law':
        return ['immigration'];

      case 'banking & finance':
        return [
          'banking',
          'finance',
        ];

      case 'constitutional law':
        return ['constitutional'];

      case 'narcotics':
        return ['narcotics'];

      case 'nab & fia':
        return [
          'nab',
          'fia',
        ];

      case 'consumer protection':
        return [
          'consumer',
          'consumer protection',
        ];

      case 'cyber crime & harassment':
        return [
          'cyber',
          'cyber crime',
          'harassment',
        ];

      case 'medical & drugs':
        return [
          'medical',
          'drugs',
          'pharmaceutical',
        ];

      case 'bor / revenue':
        return [
          'bor',
          'revenue',
        ];

      case 'environmental law':
        return [
          'environmental',
          'environment',
        ];

      case 'intellectual property':
        return [
          'intellectual property',
          'ip',
          'copyright',
          'trademark',
          'patent',
        ];

      case 'alternative dispute resolution (adr)':
        return [
          'alternative dispute resolution',
          'adr',
          'mediation',
          'arbitration',
        ];

      default:
        return [
          practiceArea,
        ];
    }
  }
}

String _normalize(String value) {
  return value.trim().toLowerCase();
}

/// Riverpod provider for Find Lawyer search/filter state.
final lawyerSearchProvider =
    NotifierProvider<LawyerSearchNotifier, LawyerSearchState>(
  LawyerSearchNotifier.new,
);