import 'package:flutter/material.dart';
import 'package:melhor_negocio/views/widgets/custom_button.dart';
import 'package:melhor_negocio/views/widgets/custom_input.dart';
import 'package:melhor_negocio/util/authentication.dart';
import 'package:melhor_negocio/models/user_model.dart' as u;
import 'dart:core';

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
                      padding: const EdgeInsets.only(bottom: 50),
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
                      child: CustomButton(
                          text: "Entrar",
                          onPressed: () {
                            u.User? userValidate =
                                Authentication.fieldValidation(
                                    _controllerEmail.text,
                                    _controllerPassword.text);

                            if (userValidate != null) {
                              u.User user = u.User();
                              user.email = _controllerEmail.text;
                              user.password = _controllerPassword.text;

                              Authentication.userLogin(context, user);
                            } else {
                              setState(() {
                                _errorMessage =
                                    "Campos de E-mail e Senha s??o obrigat??rios!";
                              });
                            }
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                      child: CustomButton(
                          text: "Cadastrar",
                          onPressed: () {
                            Navigator.pushNamed(context, "/register");
                          }),
                    ),
                  ]),
            ),
          )),
    );
  }
}
