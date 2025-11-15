import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

 
  Future<User?> loginUser(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw 'No user found for that email.'.tr();
        case 'wrong-password':
          throw 'Wrong password provided.'.tr();
        case 'invalid-email':
          throw 'Invalid email address.'.tr();
        default:
          throw 'Login failed. Please try again.'.tr();
      }
    } catch (e) {
      throw 'An unexpected error occurred: $e';
    }
  }

 
  User? get currentUser => _auth.currentUser;

 
  Future<void> logoutUser() async {
    await _auth.signOut();
  }
}
