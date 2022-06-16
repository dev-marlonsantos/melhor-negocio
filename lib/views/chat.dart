import 'package:flutter/material.dart';
import 'package:melhor_negocio/views/text_composer.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        elevation: 0,
      ),
      body: TextComposer(),
    );
  }
}
