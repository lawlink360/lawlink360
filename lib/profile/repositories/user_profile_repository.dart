import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_profile.dart';

class UserProfileRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  UserProfileRepository({
    required this.firestore,
    required this.auth,
  });

  Future<UserProfile> getCurrentUser() async {
    final user = auth.currentUser;

    if (user == null) {
      return UserProfile.empty();
    }

    final uid = user.uid;

    final doc = await firestore.collection('users').doc(uid).get();

    if (!doc.exists) {
      return UserProfile.empty();
    }

    return UserProfile.fromMap(doc.data()!);
  }

  Future<void> updateRole(String role) async {
    final user = auth.currentUser;

    if (user == null) {
      throw Exception('No authenticated user found. Please log in again.');
    }

    final uid = user.uid;

    await firestore.collection('users').doc(uid).update({
      'role': role,
    });
  }
}