import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:melhor_negocio/models/userModel.dart' as u;

class Authentication {
  static User? currentUser;

  static userLogin(BuildContext context, u.User user) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth
        .signInWithEmailAndPassword(email: user.email, password: user.password)
        .then((firebaseUser) {
      Navigator.pushReplacementNamed(context, "");
    });
  }

  static u.User? fieldValidation(
      String _controllerEmail, String _controllerPassword) {
    u.User? user;
    if (_controllerEmail.isNotEmpty && _controllerPassword.isNotEmpty) {
      user = u.User();
      user.email = _controllerEmail;
      user.password = _controllerPassword;
    }

    return user;
  }

  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? _user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        _user = userCredential.user;
        currentUser = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          return null;
        }
      } catch (e) {
        // handle the error here
        return null;
      }
    }

    return _user;
  }
}
