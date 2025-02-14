import 'package:firebase_auth/firebase_auth.dart';

Future<UserCredential?> signInUser({
  required String email,
  required String password,
}) async {
  try {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case 'user-not-found':
        print('No user found for that email.');
        break;
      case 'wrong-password':
        print('Incorrect password.');
        break;
      default:
        print('Error: ${e.message}');
    }
  } catch (e) {
    print('Unexpected error: $e');
  }
  return null;
}
