import 'package:meta/meta.dart';

import 'scanner_page.dart';

enum ScannerStatus {
  idle,
  capturing,
  processing,
  ready,
  error,
}

@immutable
class ScannerState {
  const ScannerState({
    this.status = ScannerStatus.idle,
    this.pages = const [],
    this.activePageIndex = 0,
    this.error,
  });

  final ScannerStatus status;
  final List<ScannerPage> pages;
  final int activePageIndex;
  final String? error;

  ScannerState copyWith({
    ScannerStatus? status,
    List<ScannerPage>? pages,
    int? activePageIndex,
    String? error,
    bool clearError = false,
  }) {
    return ScannerState(
      status: status ?? this.status,
      pages: pages ?? this.pages,
      activePageIndex: activePageIndex ?? this.activePageIndex,
      error: clearError ? null : (error ?? this.error),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status.name,
      'pages': pages.map((p) => p.toMap()).toList(),
      'activePageIndex': activePageIndex,
      'error': error,
    };
  }

  factory ScannerState.fromMap(Map<String, dynamic> map) {
    return ScannerState(
      status: ScannerStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => ScannerStatus.idle,
      ),
      pages: (map['pages'] as List)
          .map((e) => ScannerPage.fromMap((e as Map).cast<String, dynamic>()))
          .toList(),
      activePageIndex: map['activePageIndex'] as int? ?? 0,
      error: map['error'] as String?,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ScannerState &&
        other.status == status &&
        _listEquals(other.pages, pages) &&
        other.activePageIndex == activePageIndex &&
        other.error == error;
  }

  @override
  int get hashCode => Object.hash(
        status,
        Object.hashAll(pages),
        activePageIndex,
        error,
      );
}

bool _listEquals<T>(List<T> a, List<T> b) {
  if (a.length != b.length) return false;
  for (int i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}