import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

//final googleSignProvider = FutureProvider((ref) => GoogleFirebaseAuth());

class GoogleFirebaseAuth {
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  //final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential> signinWithGoogle() async {
    final GoogleSignInAccount? account = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await account!.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signoutWithGoogle() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }
}
