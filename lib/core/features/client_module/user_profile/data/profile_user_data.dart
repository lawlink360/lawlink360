import '../models/profile_user.dart';

class ProfileUserData {
  static const ProfileUser currentUser = ProfileUser(
    name: "Muhammad Ali",
    email: "muhammad@example.com",
    phone: "+92 300 1234567",
    imageUrl: "assets/images/profile_face.png",  // Changed from profile.png to profile_image.png
    verified: true,
  );
}