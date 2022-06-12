import 'package:flutter/material.dart';

class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chats"),
      ),
      body: Container(
          padding: const EdgeInsets.all(16),
          child: Center(
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                          child: ElevatedButton(
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                              child: Text(
                                "Chat",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, "/conversa");
                            },
                          ))
                    ]),
              ))),
    );
  }
}
