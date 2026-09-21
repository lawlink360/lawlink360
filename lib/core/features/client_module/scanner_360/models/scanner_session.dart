import 'package:meta/meta.dart';

import 'scan_settings.dart';
import 'scanner_mode.dart';
import 'scanner_page.dart';

@immutable
class ScannerSession {
  const ScannerSession({
    required this.id,
    required this.mode,
    required this.pages,
    required this.settings,
    required this.startedAt,
    this.isDirty = false,
  });

  final String id;
  final ScannerMode mode;
  final List<ScannerPage> pages;
  final ScanSettings settings;
  final DateTime startedAt;
  final bool isDirty;

  ScannerSession copyWith({
    String? id,
    ScannerMode? mode,
    List<ScannerPage>? pages,
    ScanSettings? settings,
    DateTime? startedAt,
    bool? isDirty,
  }) {
    return ScannerSession(
      id: id ?? this.id,
      mode: mode ?? this.mode,
      pages: pages ?? this.pages,
      settings: settings ?? this.settings,
      startedAt: startedAt ?? this.startedAt,
      isDirty: isDirty ?? this.isDirty,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mode': mode.name,
      'pages': pages.map((p) => p.toMap()).toList(),
      'settings': settings.toMap(),
      'startedAt': startedAt.toIso8601String(),
      'isDirty': isDirty,
    };
  }

  factory ScannerSession.fromMap(Map<String, dynamic> map) {
    return ScannerSession(
      id: map['id'] as String,
      mode: ScannerMode.values.firstWhere(
        (e) => e.name == map['mode'],
        orElse: () => ScannerMode.document,
      ),
      pages: (map['pages'] as List)
          .map((e) => ScannerPage.fromMap((e as Map).cast<String, dynamic>()))
          .toList(),
      settings: ScanSettings.fromMap(
        (map['settings'] as Map).cast<String, dynamic>(),
      ),
      startedAt: DateTime.parse(map['startedAt'] as String),
      isDirty: map['isDirty'] as bool? ?? false,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ScannerSession &&
        other.id == id &&
        other.mode == mode &&
        _listEquals(other.pages, pages) &&
        other.settings == settings &&
        other.startedAt == startedAt &&
        other.isDirty == isDirty;
  }

  @override
  int get hashCode => Object.hash(
        id,
        mode,
        Object.hashAll(pages),
        settings,
        startedAt,
        isDirty,
      );
}

bool _listEquals<T>(List<T> a, List<T> b) {
  if (a.length != b.length) return false;
  for (int i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}