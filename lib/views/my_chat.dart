import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:melhor_negocio/models/chat_model.dart';
import 'package:melhor_negocio/models/post_model.dart';
import 'package:melhor_negocio/models/talk_model.dart';
import 'package:melhor_negocio/util/authentication.dart';
import 'package:melhor_negocio/views/widgets/text_composer.dart';

class MyChat extends StatefulWidget {
  Post? post = Post();
  MyChat(this.post, {Key? key}) : super(key: key);

  @override
  State<MyChat> createState() => _MyChatState();
}

class _MyChatState extends State<MyChat> {
  Post? _post;
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _post = widget.post;
  }

  void _sendMessage(Chat message) async {
    Chat chat = Chat();
    try {
      if (message.type == 'image') {
        Reference firebaseStorageRef = FirebaseStorage.instance
            .ref()
            .child(DateTime.now().millisecondsSinceEpoch.toString());
        TaskSnapshot uploadTask =
            await firebaseStorageRef.putFile(message.image);
        String url = await uploadTask.ref.getDownloadURL();

        chat.imgUrl = url;
      }

      chat.idUser = Authentication.currentUser!.idUser;
      chat.idPost = _post!.id;
      chat.dateTime = Timestamp.now();
      chat.type = message.type;

      if (message.type == 'text') chat.text = message.text;

      await db
          .collection('messages')
          .doc(chat.idUser)
          .collection(_post!.uidUser)
          .add(chat.toMap());

      await db
          .collection('messages')
          .doc(_post!.uidUser)
          .collection(chat.idUser)
          .add(chat.toMap());

      _saveTalk(chat);
    } catch (error) {
      print(error.toString());
    }
  }

  _saveTalk(Chat chat) {
    //Save talk Sender
    Talk tSender = Talk();
    tSender.idUserSender = chat.idUser;
    tSender.idUserReceiver = _post!.uidUser;
    tSender.text = chat.text;
    tSender.name = widget.post!.title;
    tSender.imgUrl = widget.post!.images[0];
    tSender.type = chat.type;
    tSender.idPost = _post!.id;
    tSender.salvar();

    //Save talk Receiver
    Talk tReceiver = Talk();
    tReceiver.idUserSender = _post!.uidUser;
    tReceiver.idUserReceiver = chat.idUser;
    tReceiver.text = chat.text;
    tReceiver.name = widget.post!.title;
    tReceiver.imgUrl = widget.post!.images[0];
    tReceiver.type = chat.type;
    tReceiver.idPost = _post!.id;
    tReceiver.salvar();
  }

  @override
  Widget build(BuildContext context) {
    var stream = StreamBuilder(
        stream: db
            .collection('messages')
            .doc(Authentication.currentUser!.idUser)
            .collection(_post!.uidUser)
            .orderBy('dateTime')
            .snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  children: const [
                    Text("Carregando Mensagens"),
                    CircularProgressIndicator()
                  ],
                ),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              QuerySnapshot? querySnapshot =
                  snapshot.data as QuerySnapshot<Object?>?;

              if (snapshot.hasError) {
                return const Expanded(
                    child: Text("Erro ao carregar os dados!"));
              } else {
                return Expanded(
                  child: ListView.builder(
                      itemCount: querySnapshot!.docs.length,
                      itemBuilder: (context, indice) {
                        List<DocumentSnapshot> messages =
                            querySnapshot.docs.toList();
                        DocumentSnapshot item = messages[indice];

                        double largeContainer =
                            MediaQuery.of(context).size.width;

                        Alignment alignment = Alignment.centerRight;
                        Color boxColor =
                            const Color.fromARGB(255, 197, 49, 223);
                        Color fontColor = Colors.white;

                        // Verifico se foi eu que enviei E se foi nesse an??ncio
                        bool userSender = item['idUser'] ==
                            Authentication.currentUser!.idUser;
                        bool samePost = item['idPost'] == _post!.id;

                        bool isMine = userSender && samePost;

                        if (!isMine) {
                          alignment = Alignment.centerLeft;
                          //boxColor = Colors.white;
                          //fontColor = Colors.black;
                          isMine = false;
                          boxColor = Colors.white60;
                          fontColor = Colors.white;
                        }

                        return ((isMine) || (!isMine && samePost))
                            ? Align(
                                alignment: alignment,
                                child: Padding(
                                  padding: EdgeInsets.all(6),
                                  child: Container(
                                      width: largeContainer * 0.75,
                                      padding: EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                          color: boxColor,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8))),
                                      child: Column(
                                        children: [
                                          Text(item["text"],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: fontColor)),
                                          const Padding(
                                            padding: EdgeInsets.only(left: 8),
                                          )
                                        ],
                                      )),
                                ),
                              )
                            : Container();
                      }),
                );
              }
          }
        });

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Row(
            children: [
              CircleAvatar(
                maxRadius: 20,
                backgroundColor: Colors.grey,
                backgroundImage: _post!.images[0] != ""
                    ? NetworkImage(_post!.images[0])
                    : null,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(_post!.title),
              )
            ],
          )),
      body: Container(
        color: const Color.fromARGB(255, 78, 78, 78),
        child: SafeArea(
            child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              stream,
              TextComposer(_sendMessage),
            ],
          ),
        )),
      ),
    );
  }
}
