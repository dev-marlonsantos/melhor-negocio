import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                  const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                      child: TextField(
                        autofocus: true,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                            hintText: "Nome Completo",
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      )),
                  const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                      child: TextField(
                        autofocus: true,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                            hintText: "E-mail",
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      )),
                  const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                      child: TextField(
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                            hintText: "Senha",
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      )),
                  const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                      child: TextField(
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                            hintText: "Repita a Senha",
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      )),
                  const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                      child: TextField(
                        autofocus: true,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                            hintText: "Telefone",
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      )),
                  ElevatedButton(
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      child: Text(
                        "Cadastrar",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    onPressed: () {},
                  )
                ]),
          ))),
    );
  }
}
