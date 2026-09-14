class LawFirm {
  final String id;
  final String name;
  final String location;
  final String description;
  final List<String> practiceAreas;
  final double rating;
  final int lawyersCount;
  final bool verified;

  final double consultationFee;
  final String specializationSummary;
  final bool isOnline;

  final bool isFeatured;
  final DateTime? promotionStart;
  final DateTime? promotionEnd;
  final int promotionPriority;

  const LawFirm({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.practiceAreas,
    required this.rating,
    required this.lawyersCount,
    this.verified = true,
    this.consultationFee = 0,
    this.specializationSummary = '',
    this.isOnline = false,
    this.isFeatured = false,
    this.promotionStart,
    this.promotionEnd,
    this.promotionPriority = 0,
  });

  bool get hasActivePromotion {
    if (!isFeatured) return false;

    final now = DateTime.now();

    if (promotionStart != null && now.isBefore(promotionStart!)) {
      return false;
    }

    if (promotionEnd != null && now.isAfter(promotionEnd!)) {
      return false;
    }

    return true;
  }

  LawFirm copyWith({
    String? id,
    String? name,
    String? location,
    String? description,
    List<String>? practiceAreas,
    double? rating,
    int? lawyersCount,
    bool? verified,
    double? consultationFee,
    String? specializationSummary,
    bool? isOnline,
    bool? isFeatured,
    DateTime? promotionStart,
    DateTime? promotionEnd,
    int? promotionPriority,
  }) {
    return LawFirm(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      description: description ?? this.description,
      practiceAreas: practiceAreas ?? this.practiceAreas,
      rating: rating ?? this.rating,
      lawyersCount: lawyersCount ?? this.lawyersCount,
      verified: verified ?? this.verified,
      consultationFee: consultationFee ?? this.consultationFee,
      specializationSummary:
          specializationSummary ?? this.specializationSummary,
      isOnline: isOnline ?? this.isOnline,
      isFeatured: isFeatured ?? this.isFeatured,
      promotionStart: promotionStart ?? this.promotionStart,
      promotionEnd: promotionEnd ?? this.promotionEnd,
      promotionPriority: promotionPriority ?? this.promotionPriority,
    );
  }

  factory LawFirm.fromMap(
    Map<String, dynamic> map, {
    String id = '',
  }) {
    return LawFirm(
      id: id,
      name: _readString(map['name']),
      location: _readString(map['location']),
      description: _readString(map['description']),
      practiceAreas: _readStringList(map['practiceAreas']),
      rating: _readDouble(map['rating']),
      lawyersCount: _readInt(map['lawyersCount']),
      verified: _readBool(
        map['verified'],
        defaultValue: true,
      ),
      consultationFee: _readDouble(map['consultationFee']),
      specializationSummary:
          _readString(map['specializationSummary']),
      isOnline: _readBool(map['isOnline']),
      isFeatured: _readBool(map['isFeatured']),
      promotionStart: _readDateTime(map['promotionStart']),
      promotionEnd: _readDateTime(map['promotionEnd']),
      promotionPriority: _readInt(map['promotionPriority']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'location': location,
      'description': description,
      'practiceAreas': practiceAreas,
      'rating': rating,
      'lawyersCount': lawyersCount,
      'verified': verified,
      'consultationFee': consultationFee,
      'specializationSummary': specializationSummary,
      'isOnline': isOnline,
      'isFeatured': isFeatured,
      'promotionStart': promotionStart?.toIso8601String(),
      'promotionEnd': promotionEnd?.toIso8601String(),
      'promotionPriority': promotionPriority,
    };
  }
}

String _readString(dynamic value) {
  return value is String ? value : '';
}

List<String> _readStringList(dynamic value) {
  if (value is List) {
    return value.whereType<String>().toList();
  }

  return const [];
}

double _readDouble(dynamic value) {
  if (value is num) {
    return value.toDouble();
  }

  return 0;
}

int _readInt(dynamic value) {
  if (value is num) {
    return value.toInt();
  }

  return 0;
}

bool _readBool(
  dynamic value, {
  bool defaultValue = false,
}) {
  return value is bool ? value : defaultValue;
}

DateTime? _readDateTime(dynamic value) {
  if (value is DateTime) {
    return value;
  }

  if (value is String && value.isNotEmpty) {
    return DateTime.tryParse(value);
  }

  return null;
}