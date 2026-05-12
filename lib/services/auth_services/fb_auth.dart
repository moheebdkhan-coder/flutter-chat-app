import 'package:firebase_auth/firebase_auth.dart';

class FbAuth {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static Future<String?> logInWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message ?? "An unknown error occured";
    }
  }

  static Future<String?> signUpWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message ?? "An unknown error occured";
    }
  }

  static Future<void> logOut() async => _auth.signOut();
}
