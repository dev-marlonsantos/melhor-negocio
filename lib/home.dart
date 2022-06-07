import 'package:flutter/material.dart';
import 'package:melhor_negocio/register.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                  const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
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
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
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
                        onPressed: () {},
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
                          MaterialPageRoute(
                              builder: (context) => const Register());
                        },
                      ))
                ]),
          ))),
    );
  }
}
