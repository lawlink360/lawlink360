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
  });

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
    );
  }
}