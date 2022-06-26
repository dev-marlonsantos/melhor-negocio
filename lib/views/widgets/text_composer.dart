// ignore_for_file: non_constant_identifier_names, use_key_in_widget_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:melhor_negocio/models/chat_model.dart' as model;

class TextComposer extends StatefulWidget {
  const TextComposer(this.SendMessage);

  final void Function(model.Chat message) SendMessage;

  @override
  State<TextComposer> createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  bool _isComposing = false;
  Color _colorButtonSend = const Color.fromARGB(255, 141, 139, 141);
  final TextEditingController _controller = TextEditingController();
  model.Chat message = model.Chat();

  void _reset() {
    _controller.clear();
    setState(() {
      _isComposing = false;
      _colorButtonSend = const Color.fromARGB(255, 141, 139, 141);
      message.Clear();
    });
  }

  Future _sendImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      message.type = "image";
      message.image = File(pickedImage.path);
      widget.SendMessage(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(children: <Widget>[
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(32, 16, 0, 16),
              hintText: 'Enviar uma mensagem',
              filled: true,
              fillColor: Colors.white,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
              prefixIcon: IconButton(
                icon: const Icon(Icons.photo_camera,
                    color: Color.fromARGB(255, 226, 167, 236)),
                onPressed: () async {
                  _sendImage();
                  _reset();
                },
              ),
            ),
            onChanged: (text) {
              setState(() {
                _isComposing = text.isNotEmpty;
                _colorButtonSend =
                    _isComposing ? const Color(0xff9c27b0) : Color(0xFF9C9C9C);
              });
            },
            onSubmitted: (text) {
              message.type = 'text';
              message.text = text;
              widget.SendMessage(message);
              _reset();
            },
          ),
        )),
        FloatingActionButton(
          child: const Icon(Icons.send, color: Colors.white),
          backgroundColor: _colorButtonSend,
          mini: true,
          onPressed: _isComposing
              ? () {
                  message.type = 'text';
                  message.text = _controller.text;
                  widget.SendMessage(message);
                  _reset();
                }
              : null,
        ),
      ]),
    );
  }
}
