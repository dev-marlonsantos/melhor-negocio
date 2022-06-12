import 'package:flutter/material.dart';

class Conversa extends StatefulWidget {
  const Conversa({Key? key}) : super(key: key);

  @override
  State<Conversa> createState() => _ConversaState();
}

class _ConversaState extends State<Conversa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Conversa"),
      ),
      body: Container(
          padding: const EdgeInsets.all(16),
          child: Center(
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[

                    ]),
              ))),
    );
  }
}
