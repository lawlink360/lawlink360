class ProfileUser {
  final String name;
  final String email;
  final String phone;
  final String imageUrl;
  final bool verified;

  const ProfileUser({
    required this.name,
    required this.email,
    required this.phone,
    required this.imageUrl,
    required this.verified,
  });
}