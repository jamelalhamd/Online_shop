import 'package:firebase_auth/firebase_auth.dart';

Future<UserCredential?> SinuploginUser({
  required String email,
  required String password,
  required bool isLogin, // true for login, false for sign-up
}) async {
  try {
    if (isLogin) {
      // Sign in the user
      return await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } else {
      // Create a new user
      return await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    } else if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    } else {
      print('FirebaseAuthException: ${e.message}');
    }
  } catch (e) {
    print('Error: $e');
  }
  return null;
}
