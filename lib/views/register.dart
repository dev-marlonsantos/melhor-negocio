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
  File? _imagePicked;

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

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword =
      TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();

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
        appBar: AppBar(
          title: const Text(""),
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Center(
              child: SingleChildScrollView(
                  child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                  child: GestureDetector(
                    onTap: () {
                      _imagePicker();
                    },
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: const Color(0xff9c27b0),
                      child: _imagePicked != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(150),
                              child: Image.file(
                                _imagePicked!,
                                width: 150,
                                height: 150,
                                fit: BoxFit.fitHeight,
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(150)),
                              width: 150,
                              height: 150,
                              child: Icon(
                                Icons.add_a_photo,
                                color: Colors.grey[800],
                                size: 50,
                              ),
                            ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: CustomInput(
                      controller: _controllerName,
                      hint: "Nome Completo",
                      type: TextInputType.text,
                    )),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: CustomInput(
                      controller: _controllerEmail,
                      hint: "E-mail",
                      type: TextInputType.emailAddress,
                    )),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: CustomInput(
                      controller: _controllerPassword,
                      hint: "Senha",
                      obscure: true,
                      type: TextInputType.visiblePassword,
                    )),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: CustomInput(
                      controller: _controllerConfirmPassword,
                      hint: "Repita a Senha",
                      obscure: true,
                      type: TextInputType.visiblePassword,
                    )),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: CustomInput(
                        controller: _controllerPhone,
                        hint: "Número de Celular",
                        type: TextInputType.phone,
                        validator: (valor) {
                          return Validador()
                              .add(Validar.OBRIGATORIO,
                                  msg: "Campo obrigatório")
                              .valido(valor);
                        })),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: CustomButton(
                      text: "Cadastrar",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _fieldValidation();
                        }
                      }),
                ),
              ],
            ),
          ))),
        ));
  }
}
