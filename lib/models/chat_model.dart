import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  String idUserSender = "";
  String idUserReceiver = "";
  String idPost = "";
  String text = "";
  String imgUrl = "";
  String type = "";
  Timestamp dateTime = Timestamp.now();

  Chat();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "idUserSender": idUserSender,
      "idUserReceiver": idUserReceiver,
      "idPost": idPost,
      "text": text,
      "imgUrl": imgUrl,
      "type": type,
      "dateTime": dateTime
    };
    return map;
  }
}
