import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TextComposer extends StatefulWidget {
  TextComposer(this.SendMessage);

  final void Function({String text, File? imgFile}) SendMessage;

  @override
  State<TextComposer> createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  bool _isComposing = false;
  Color _colorIconSend = Color.fromARGB(255, 141, 139, 141);
  TextEditingController _controller = TextEditingController();

  void _reset() {
    _controller.clear();
    setState(() {
      _isComposing = false;
      _colorIconSend = Color.fromARGB(255, 141, 139, 141);
    });
  }

  Future _imagePicker() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedImage != null) {
      final pickedImageFile = File(pickedImage.path);
      widget.SendMessage(imgFile: pickedImageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(children: <Widget>[
        IconButton(
          icon: Icon(Icons.photo_camera, color: Color(0xff9c27b0)),
          onPressed: () async {
            _imagePicker();
          },
        ),
        Expanded(
          child: TextField(
            controller: _controller,
            decoration:
                InputDecoration.collapsed(hintText: 'Enviar uma mensagem'),
            onChanged: (text) {
              setState(() {
                _isComposing = text.isNotEmpty;
                _colorIconSend = _isComposing
                    ? Color(0xff9c27b0)
                    : Color.fromARGB(255, 141, 139, 141);
              });
            },
            onSubmitted: (text) {
              widget.SendMessage(text: text);
              _reset();
            },
          ),
        ),
        IconButton(
          icon: Icon(Icons.send, color: _colorIconSend),
          onPressed: _isComposing
              ? () {
                  widget.SendMessage(text: _controller.text);
                  _reset();
                }
              : null,
        ),
      ]),
    );
  }
}
