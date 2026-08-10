import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/lawyer_model.dart';

/// State for the Find Lawyer feature.
class LawyerSearchState {
  final List<Lawyer> lawyers;
  final String searchQuery;
  final String selectedPracticeArea;
  final String selectedLocation;
  final bool isLoading;

  const LawyerSearchState({
    this.lawyers = const [],
    this.searchQuery = '',
    this.selectedPracticeArea = 'All',
    this.selectedLocation = 'All',
    this.isLoading = false,
  });

  LawyerSearchState copyWith({
    List<Lawyer>? lawyers,
    String? searchQuery,
    String? selectedPracticeArea,
    String? selectedLocation,
    bool? isLoading,
  }) {
    return LawyerSearchState(
      lawyers: lawyers ?? this.lawyers,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedPracticeArea:
          selectedPracticeArea ?? this.selectedPracticeArea,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// Controls lawyers, searching and filtering.
class LawyerNotifier extends Notifier<LawyerSearchState> {
  @override
  LawyerSearchState build() {
    return const LawyerSearchState(
      lawyers: [
        Lawyer(
          id: 'lawyer_001',
          name: 'Adv. Ahmed Khan',
          speciality: 'Criminal Lawyer',
          location: 'Islamabad',
          rating: 4.9,
          experience: 15,
          verified: true,
          casesHandled: 560,
        ),
        Lawyer(
          id: 'lawyer_002',
          name: 'Adv. Sara Malik',
          speciality: 'Family Lawyer',
          location: 'Lahore',
          rating: 4.8,
          experience: 11,
          verified: true,
          casesHandled: 420,
        ),
        Lawyer(
          id: 'lawyer_003',
          name: 'Adv. Ali Raza',
          speciality: 'Civil Lawyer',
          location: 'Karachi',
          rating: 4.7,
          experience: 9,
          verified: true,
          casesHandled: 315,
        ),
      ],
    );
  }

  /// Update the search text.
  void setSearchQuery(String query) {
    state = state.copyWith(
      searchQuery: query,
    );
  }

  /// Select a practice area.
  void setPracticeArea(String practiceArea) {
    state = state.copyWith(
      selectedPracticeArea: practiceArea,
    );
  }

  /// Select a location.
  void setLocation(String location) {
    state = state.copyWith(
      selectedLocation: location,
    );
  }

  /// Clear search and filters.
  void clearFilters() {
    state = state.copyWith(
      searchQuery: '',
      selectedPracticeArea: 'All',
      selectedLocation: 'All',
    );
  }

  /// Set loading state.
  void setLoading(bool loading) {
    state = state.copyWith(
      isLoading: loading,
    );
  }

  /// Returns lawyers according to the current search/filter state.
  List<Lawyer> get filteredLawyers {
    final query = state.searchQuery.trim().toLowerCase();

    return state.lawyers.where((lawyer) {
      final matchesSearch =
          query.isEmpty ||
          lawyer.name.toLowerCase().contains(query) ||
          lawyer.speciality.toLowerCase().contains(query) ||
          lawyer.location.toLowerCase().contains(query);

      final matchesPracticeArea =
          state.selectedPracticeArea == 'All' ||
          lawyer.speciality
              .toLowerCase()
              .contains(state.selectedPracticeArea.toLowerCase());

      final matchesLocation =
          state.selectedLocation == 'All' ||
          lawyer.location.toLowerCase() ==
              state.selectedLocation.toLowerCase();

      return matchesSearch &&
          matchesPracticeArea &&
          matchesLocation;
    }).toList();
  }
}

/// Riverpod provider for Find Lawyer.
final lawyerProvider =
    NotifierProvider<LawyerNotifier, LawyerSearchState>(
  LawyerNotifier.new,
);