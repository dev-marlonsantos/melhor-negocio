import 'dart:async';

import 'package:flutter/material.dart';
import 'package:melhor_negocio/models/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:melhor_negocio/models/talk_model.dart';
import 'package:melhor_negocio/util/authentication.dart';
import 'package:melhor_negocio/views/widgets/custom_button.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final _controller = StreamController<QuerySnapshot>.broadcast();
  List<Talk> _listTalks = [];
  @override
  void initState() {
    super.initState();

    Talk talk = Talk();
    talk.name = "Amor";
    talk.text = "Tudo bem amor?";
    talk.imgUrl =
        "https://firebasestorage.googleapis.com/v0/b/melhor-negocio-6a465.appspot.com/o/1655956456486?alt=media&token=453d1cca-fe72-43a5-bd90-a5936d994a1e";

    _listTalks.add(talk);
    _initializeData();
  }

  _initializeData() async {
    _addListenerChatlist();
  }

  Future<Stream<QuerySnapshot>> _addListenerChatlist() {
    Stream<QuerySnapshot> stream = db
        .collection("talks")
        .doc(Authentication.currentUser!.idUser)
        .collection('lastTalk')
        .snapshots();

    stream.listen((data) {
      _controller.add(data);
    });

    throw Exception("erro");
  }

  @override
  Widget build(BuildContext context) {
    var stream = StreamBuilder(
        stream: _controller.stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  children: const <Widget>[
                    Text("Carregando conversas"),
                    CircularProgressIndicator()
                  ],
                ),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) {
                return const Text('Erro ao carregar os dados!');
              } else {
                QuerySnapshot? querySnapshot =
                    snapshot.data as QuerySnapshot<Object?>?;

                if (querySnapshot == null || querySnapshot.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      'Você não tem nenhuma mensagem ainda :(',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  );
                }

                return ListView.builder(
                    itemCount: querySnapshot.docs.length,
                    itemBuilder: (_, indice) {
                      List<DocumentSnapshot> conversas =
                          querySnapshot.docs.toList();
                      DocumentSnapshot item = conversas[indice];

                      String imgUrl = item['imgUrl'];
                      String text = item['text'];
                      String type = item['type'];
                      String name = item['name'];

                      return ListTile(
                        contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                        leading: CircleAvatar(
                          maxRadius: 30,
                          backgroundColor: Colors.grey,
                          backgroundImage:
                              imgUrl != null ? NetworkImage(imgUrl) : null,
                        ),
                        title: Text(
                          text,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        subtitle: Text(
                          type == "text" ? text : "imagem ...",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      );
                    });
              }
          }
        });

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Lista de Conversas"),
          elevation: 0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[stream],
        ));
  }
}
