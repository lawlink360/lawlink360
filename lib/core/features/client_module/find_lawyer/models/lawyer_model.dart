class Lawyer {
  final String id;
  final String name;
  final String speciality;
  final String location;
  final double rating;
  final int experience;
  final bool verified;
  final int casesHandled;
  final String phone;
  final String email;

  /// Standard consultation fee shown to clients.
  final double consultationFee;

  /// Short description of the legal matters handled by the lawyer.
  final String specializationSummary;

  /// Indicates whether the lawyer is currently available online.
  final bool isOnline;

  /// Indicates whether the lawyer accepts instant consultations.
  final bool instantConsultation;

  /// Lawyer gender used for client-side directory filtering.
  final String gender;

  /// Highest court level at which the lawyer practices.
  ///
  /// Expected values:
  /// lower, high, supreme
  final String courtLevel;

  /// Indicates that LawLink360 has an active promotional placement
  /// for this lawyer.
  final bool isFeatured;

  /// Optional promotion start date.
  final DateTime? promotionStart;

  /// Optional promotion end date.
  final DateTime? promotionEnd;

  /// Controls the ordering of active featured placements.
  final int promotionPriority;

  const Lawyer({
    required this.id,
    required this.name,
    required this.speciality,
    required this.location,
    required this.rating,
    required this.experience,
    this.verified = true,
    this.casesHandled = 0,
    this.phone = '',
    this.email = '',
    this.consultationFee = 0,
    this.specializationSummary = '',
    this.isOnline = false,
    this.instantConsultation = false,
    this.gender = '',
    this.courtLevel = '',
    this.isFeatured = false,
    this.promotionStart,
    this.promotionEnd,
    this.promotionPriority = 0,
  });

  /// Whether the lawyer currently has an active promotional placement.
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

  Lawyer copyWith({
    String? id,
    String? name,
    String? speciality,
    String? location,
    double? rating,
    int? experience,
    bool? verified,
    int? casesHandled,
    String? phone,
    String? email,
    double? consultationFee,
    String? specializationSummary,
    bool? isOnline,
    bool? instantConsultation,
    String? gender,
    String? courtLevel,
    bool? isFeatured,
    DateTime? promotionStart,
    DateTime? promotionEnd,
    int? promotionPriority,
  }) {
    return Lawyer(
      id: id ?? this.id,
      name: name ?? this.name,
      speciality: speciality ?? this.speciality,
      location: location ?? this.location,
      rating: rating ?? this.rating,
      experience: experience ?? this.experience,
      verified: verified ?? this.verified,
      casesHandled: casesHandled ?? this.casesHandled,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      consultationFee: consultationFee ?? this.consultationFee,
      specializationSummary:
          specializationSummary ?? this.specializationSummary,
      isOnline: isOnline ?? this.isOnline,
      instantConsultation:
          instantConsultation ?? this.instantConsultation,
      gender: gender ?? this.gender,
      courtLevel: courtLevel ?? this.courtLevel,
      isFeatured: isFeatured ?? this.isFeatured,
      promotionStart: promotionStart ?? this.promotionStart,
      promotionEnd: promotionEnd ?? this.promotionEnd,
      promotionPriority:
          promotionPriority ?? this.promotionPriority,
    );
  }

  /// Creates a Lawyer from backend data.
  factory Lawyer.fromMap(
    Map<String, dynamic> map, {
    String id = '',
  }) {
    return Lawyer(
      id: id,
      name: _readString(map['name']),
      speciality: _readString(map['speciality']),
      location: _readString(map['location']),
      rating: _readDouble(map['rating']),
      experience: _readInt(map['experience']),
      verified: _readBool(
        map['verified'],
        defaultValue: true,
      ),
      casesHandled: _readInt(map['casesHandled']),
      phone: _readString(map['phone']),
      email: _readString(map['email']),
      consultationFee:
          _readDouble(map['consultationFee']),
      specializationSummary:
          _readString(map['specializationSummary']),
      isOnline: _readBool(map['isOnline']),
      instantConsultation:
          _readBool(map['instantConsultation']),
      gender: _readString(map['gender']),
      courtLevel: _readString(map['courtLevel']),
      isFeatured: _readBool(map['isFeatured']),
      promotionStart:
          _readDateTime(map['promotionStart']),
      promotionEnd:
          _readDateTime(map['promotionEnd']),
      promotionPriority:
          _readInt(map['promotionPriority']),
    );
  }

  /// Converts the model into backend-friendly data.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'speciality': speciality,
      'location': location,
      'rating': rating,
      'experience': experience,
      'verified': verified,
      'casesHandled': casesHandled,
      'phone': phone,
      'email': email,
      'consultationFee': consultationFee,
      'specializationSummary':
          specializationSummary,
      'isOnline': isOnline,
      'instantConsultation':
          instantConsultation,
      'gender': gender,
      'courtLevel': courtLevel,
      'isFeatured': isFeatured,
      'promotionStart':
          promotionStart?.toIso8601String(),
      'promotionEnd':
          promotionEnd?.toIso8601String(),
      'promotionPriority':
          promotionPriority,
    };
  }
}

String _readString(dynamic value) {
  return value is String ? value : '';
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