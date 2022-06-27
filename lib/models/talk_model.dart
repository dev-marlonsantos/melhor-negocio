import 'package:cloud_firestore/cloud_firestore.dart';

class Talk {
  String _idUserSender = "";
  String _idUserReceiver = "";
  String _idPost = "";
  String _type = "";
  String _text = "";
  String _imgUrl = "";
  String _name = "";

  Talk();

  salvar() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db
        .collection("talks")
        .doc(this.idUserSender)
        .collection("lastTalk")
        .doc(this.idUserReceiver)
        .set(this.toMap());
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "idUserSender": this.idUserSender,
      "idUserReceiver": this.idUserReceiver,
      "name": this.name,
      "idPost": this.idPost,
      "type": this.type,
      "text": this.text,
      "imgUrl": this.imgUrl
    };
    return map;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get idUserSender => _idUserSender;

  set idUserSender(String value) {
    _idUserSender = value;
  }

  String get idUserReceiver => _idUserReceiver;

  set idUserReceiver(String value) {
    _idUserReceiver = value;
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
}
