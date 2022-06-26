import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:melhor_negocio/models/user_model.dart' as u;
import 'package:cloud_firestore/cloud_firestore.dart' as db;

class Authentication {
  static u.User? currentUser;

  static userLogin(BuildContext context, u.User user) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth
        .signInWithEmailAndPassword(email: user.email, password: user.password)
        .then((firebaseUser) async {
      db.DocumentSnapshot doc = await db.FirebaseFirestore.instance
          .collection('users')
          .doc(user.email)
          .get();

      currentUser = u.User();
      currentUser!.idUser = firebaseUser.user!.uid;
      currentUser!.name = doc.get('senderName');
      currentUser!.imageUrl = doc.get('senderPhotoUrl');
      currentUser!.phone = doc.get('senderPhone');
      currentUser!.email = doc.get('senderEmail');

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
}
