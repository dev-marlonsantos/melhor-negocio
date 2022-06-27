import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  String _idUser = "";
  String _idPost = "";
  String _type = "";
  String _text = "";
  String _imgUrl = "";
  File _image = File("");
  Timestamp _dateTime = Timestamp.now();

  Chat();

  String get idUser => _idUser;

  set idUser(String value) {
    _idUser = value;
  }

  String get idPost => _idPost;

  set idPost(String value) {
    _idPost = value;
  }

  String get type => _type;

  set type(String value) {
    _type = value;
  }

  String get text => _text;

  set text(String value) {
    _text = value;
  }

  String get imgUrl => _imgUrl;

  set imgUrl(String value) {
    _imgUrl = value;
  }

  File get image => _image;

  set image(File value) {
    _image = value;
  }

  Timestamp get dateTime => _dateTime;

  set dateTime(Timestamp value) {
    _dateTime = value;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "idUser": idUser,
      "idPost": idPost,
      "type": type,
      "text": text,
      "imgUrl": imgUrl,
      "dateTime": dateTime
    };
    return map;
  }

  void Clear() {
    this.idUser = "";
    this.idPost = "";
    this.type = "";
    this.text = "";
    this.imgUrl = "";
    this.image = File("");
  }

  Chat.fromDocumentSnapshot(DocumentSnapshot item) {
    this.idUser = item.get('idUser');
    this.idPost = item.get('idPost');
    this.imgUrl = item.get('imgUrl');
    this.text = item.get('text');
    this.type = item.get('type');
    this.dateTime = item.get('dateTime');
  }
}
