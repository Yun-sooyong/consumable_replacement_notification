import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleFirebaseAuth {
  Future<UserCredential?> signinWithGoogle() async {
    final GoogleSignInAccount? account = await GoogleSignIn().signIn();
    if (account == null) {
      //SystemNavigator.pop();
      return null;
    }

    final GoogleSignInAuthentication googleAuth = await account.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signoutWithGoogle() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }
}

 

// TODO handle 및 로그인 다시 만들기 
// class HandledGoogleAuth {
//   Future<void> _handleGetConnect() {
    
//   }
// }
