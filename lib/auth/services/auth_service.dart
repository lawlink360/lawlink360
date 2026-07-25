import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  // Current logged-in user
  User? get currentUser => _auth.currentUser;

  // ==========================
  // Create Account
  // ==========================
  Future<UserCredential> signUp({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    UserCredential userCredential =
        await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );

    await _firestore
        .collection('users')
        .doc(userCredential.user!.uid)
        .set({
      'uid': userCredential.user!.uid,
      'fullName': fullName.trim(),
      'email': email.trim(),
      'phone': phone.trim(),
      'role': '',
      'profileCompleted': false,
      'createdAt': FieldValue.serverTimestamp(),
    });

    return userCredential;
  }

  // ==========================
  // Login
  // ==========================
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }

Future<UserCredential?> signInWithGoogle() async {
  try {
    await _googleSignIn.initialize();

    final GoogleSignInAccount googleUser =
        await _googleSignIn.authenticate();

    final GoogleSignInAuthentication googleAuth =
        googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    final userCredential =
        await _auth.signInWithCredential(credential);

    final user = userCredential.user!;

    final doc =
        _firestore.collection('users').doc(user.uid);

    if (!(await doc.get()).exists) {
      await doc.set({
        'uid': user.uid,
        'fullName': user.displayName ?? '',
        'email': user.email ?? '',
        'phone': user.phoneNumber ?? '',
        'role': '',
        'profileCompleted': false,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    return userCredential;
  } catch (e) {
    throw Exception(e.toString());
  }
}

  // ==========================
  // Forgot Password
  // ==========================
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(
      email: email.trim(),
    );
  }

  // ==========================
  // Logout
  // ==========================
  Future<void> signOut() async {
    await _auth.signOut();
  }
}