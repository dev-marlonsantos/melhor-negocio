import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:melhor_negocio/Authentication.dart';
import 'package:melhor_negocio/views/text_composer.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final bool mine = true;

  void _sendMessage({String text = "", File? imgFile}) async {
    Map<String, dynamic> data = {};

    if (imgFile != null) {
      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child(DateTime.now().millisecondsSinceEpoch.toString());
      TaskSnapshot uploadTask = await firebaseStorageRef.putFile(imgFile);
      String url = await uploadTask.ref.getDownloadURL();

      data['imgUrl'] = url;
      data['text'] = "";
    }

    if (text != "") {
      data['text'] = text;
      data['imgUrl'] = "";
    }

    data['time'] = Timestamp.now();
    FirebaseFirestore.instance.collection('messages').add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('messages')
                  .orderBy('time')
                  .snapshots(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );

                  default:
                    List<DocumentSnapshot> documents =
                        snapshot.data!.docs.reversed.toList();

                    return ListView.builder(
                      itemCount: documents.length,
                      reverse: true,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Row(
                            children: [
                              !mine
                                  ? Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            Authentication
                                                .currentUser!.imageUrl),
                                      ),
                                    )
                                  : Container(),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: mine
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  children: [
                                    documents[index].get('imgUrl') != ""
                                        ? Image.network(
                                            documents[index].get('imgUrl'),
                                            width: 250,
                                          )
                                        : Text(
                                            documents[index].get('text'),
                                            textAlign: mine
                                                ? TextAlign.end
                                                : TextAlign.start,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                    Text(
                                      Authentication.currentUser!.name,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              mine
                                  ? Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            Authentication
                                                .currentUser!.imageUrl),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        );
                      },
                    );
                }
              },
            ),
          ),
          TextComposer(_sendMessage),
        ],
      ),
    );
  }
}
