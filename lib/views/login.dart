import 'package:flutter/material.dart';
import 'package:melhor_negocio/views/custom_input.dart';
import 'package:melhor_negocio/views/models/user.dart' as u;
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _controllerEmail =
      TextEditingController(text: "teste@ucl.br");

  final TextEditingController _controllerPassword =
      TextEditingController(text: "123456@");

  String _errorMessage = "";

  _userLogin(u.User user) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth
        .signInWithEmailAndPassword(email: user.email, password: user.password)
        .then((firebaseUser) {
      Navigator.pushReplacementNamed(context, "");
    });
  }

  _fieldValidation() {
    String email = _controllerEmail.text;
    String password = _controllerPassword.text;
    if (email.isNotEmpty && password.isNotEmpty) {
      u.User user = u.User();
      user.email = email;
      user.password = password;
      _userLogin(user);
    } else {
      setState(() {
        _errorMessage = "Preencha o e-mail e senha!";
        print(_errorMessage);
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 42),
                    child: Image.asset(
                      "images/logo.png",
                      width: 200,
                      height: 150,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                      child: CustomInput(
                        controller: _controllerEmail,
                        hint: "E-mail",
                        autofocus: true,
                        type: TextInputType.emailAddress,
                      )),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                      child: CustomInput(
                        controller: _controllerPassword,
                        hint: "Senha",
                        obscure: true,
                        type: TextInputType.visiblePassword,
                      )),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                      child: ElevatedButton(
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                          child: Text(
                            "Entrar",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        onPressed: () {
                          _fieldValidation();
                        },
                      )),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                      child: ElevatedButton(
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                          child: Text(
                            "Cadastrar",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, "/register");
                        },
                      ))
                ]),
          ))),
    );
  }
}
