import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:validadores/validadores.dart';
import 'package:melhor_negocio/views/widgets/custom_button.dart';
import 'package:melhor_negocio/views/widgets/custom_input.dart';
import 'package:melhor_negocio/models/userModel.dart' as u;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as db;

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Future _imagePicker() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _imagePicked = pickedImageFile;
    });
  }

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword =
      TextEditingController();
  final TextEditingController _controllerConfirmPassword =
      TextEditingController();
  final TextEditingController _controllerName =
      TextEditingController();
  final TextEditingController _controllerPhone =
      TextEditingController();

  String _errorMessage = "";

  _userRegister(u.User user) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth
        .createUserWithEmailAndPassword(
            email: user.email, password: user.password)
        .then((firebaseUser) {
      auth
          .signInWithEmailAndPassword(
              email: user.email, password: user.password)
          .then((firebaseUser) {
        db.FirebaseFirestore.instance.collection('users').doc().set({
          'name': user.name,
          'phone': user.phone,
          'email': user.email,
          'imageUrl': user.imageUrl
        });

        Navigator.pushReplacementNamed(context, "/login");
      });
    });
  }

  _fieldValidation() {
    String email = _controllerEmail.text;
    String password = _controllerPassword.text;
    String name = _controllerName.text;
    String phone = _controllerPhone.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      u.User user = u.User();
      user.email = email;
      user.password = password;
      user.name = name;
      user.phone = phone;
      _userRegister(user);
    } else {
      setState(() {
        _errorMessage = "Preencha o e-mail e senha!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(16),
          child: Center(
              child: SingleChildScrollView(
            child: Column(
                    onPressed: () {
                      _imagePicker();
                    },
                  ),
                      child: CustomInput(
                        controller: _controllerPhone,
                        hint: "Número de Celular",
                        type: TextInputType.phone,
                ]),
          ))),
    );
  }
}
