import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:melhor_negocio/views/custom_input.dart';
import 'package:melhor_negocio/views/models/user.dart' as u;
import 'package:firebase_auth/firebase_auth.dart';

File _imagePicked = File("images/logo.png");

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

  final TextEditingController _controllerEmail =
      TextEditingController(text: "teste@ucl.br");

  final TextEditingController _controllerPassword =
      TextEditingController(text: "123456@");

  final TextEditingController _controllerConfirmPassword =
      TextEditingController(text: "123456@");

  final TextEditingController _controllerName =
      TextEditingController(text: "User Teste");

  final TextEditingController _controllerPhone =
      TextEditingController(text: "40028922");

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
        Navigator.pushReplacementNamed(context, "");
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
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ElevatedButton(
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      child: Text(
                        "Imagem de Perfil",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    onPressed: () {
                      _imagePicker();
                    },
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      child: Image.file(_imagePicked, width: 160, height: 160)),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                      child: CustomInput(
                        controller: _controllerName,
                        hint: "Nome Completo",
                        autofocus: true,
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
                      )),
                  ElevatedButton(
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      child: Text(
                        "Cadastrar",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    onPressed: () {
                      _fieldValidation();
                    },
                  )
                ]),
          ))),
    );
  }
}
