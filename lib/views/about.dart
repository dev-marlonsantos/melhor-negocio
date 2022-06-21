// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sobre o App"),
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.fromLTRB(32, 32, 32, 32),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Center(
                        child: Text("Desenvolvido por:",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                      Container(height: 10, alignment: Alignment.center),
                      const Center(
                        child: Text("Carlos Eduardo  &  Marlon Santos",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                      const Center(
                        child: const Text("",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                      Container(height: 15, alignment: Alignment.center),
                      const Center(
                        child: Text(
                            "Projeto para a disciplina de\nAplicativos Mobile 2022/1",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                    ]))));
  }
}
