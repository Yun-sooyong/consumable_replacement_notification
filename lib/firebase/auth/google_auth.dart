import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final googleSignProvider = FutureProvider((ref) => GoogleFirebaseAuth());

class GoogleFirebaseAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential> signWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await account!.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      return await _auth.signInWithCredential(credential);
    } on FirebaseException catch (e) {
      print(e.message);
      throw e;
    }
  }

  Future<void> logoutWithGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
