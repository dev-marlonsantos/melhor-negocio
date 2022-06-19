import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:melhor_negocio/models/postModel.dart';
import 'package:melhor_negocio/views/widgets/post_item.dart';

class MyPosts extends StatefulWidget {
  const MyPosts({Key? key}) : super(key: key);

  @override
  State<MyPosts> createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  final _controller = StreamController<QuerySnapshot>.broadcast();

  String? _idLogedUser = "";

  _logedUser() async {
    User? logedUser = FirebaseAuth.instance.currentUser;
    _idLogedUser = logedUser!.uid;
  }

  Future<StreamBuilder<QuerySnapshot>> _addListenerPosts() async {
    await _logedUser();
    FirebaseFirestore db = FirebaseFirestore.instance;
    Stream<QuerySnapshot> stream = db
        .collection("my_posts")
        .doc(_idLogedUser)
        .collection("posts")
        .snapshots();

    stream.listen((data) {
      _controller.add(data);
    });

    throw Exception("erro");
  }

  _removePost(String postId) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    db
        .collection("my_posts")
        .doc(_idLogedUser)
        .collection("posts")
        .doc(postId)
        .delete();
  }

  @override
  void initState() {
    super.initState();
    _addListenerPosts();
  }

  @override
  Widget build(BuildContext context) {
    var loadingData = Center(
        child: Column(
      children: const <Widget>[
        Text("Carregando anúncios"),
        CircularProgressIndicator()
      ],
    ));
    return Scaffold(
        appBar: AppBar(
          title: const Text("Meus anúncios"),
        ),
        floatingActionButton: FloatingActionButton(
            foregroundColor: Colors.white,
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, "/new-post");
            }),
        body: StreamBuilder(
          stream: _controller.stream,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return loadingData;
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return const Text("Erro ao carregar dados!");
                }

                QuerySnapshot? querySnapshot =
                    snapshot.data as QuerySnapshot<Object?>?;

                return ListView.builder(
                    itemCount: querySnapshot?.docs.length,
                    itemBuilder: (_, indice) {
                      List<DocumentSnapshot> posts =
                          querySnapshot!.docs.toList();
                      DocumentSnapshot documentSnapshot = posts[indice];
                      Post post = Post.fromDocumentSnapshot(documentSnapshot);
                      return PostItem(
                        post: post,
                        onPressedRemove: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Confirmar"),
                                  content: const Text(
                                      "Deseja realmente excluir o anúncio?"),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      child: const Text("Cancelar",
                                          style:
                                              TextStyle(color: Colors.white)),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.red),
                                      ),
                                      child: const Text("Remover",
                                          style:
                                              TextStyle(color: Colors.white)),
                                      onPressed: () {
                                        _removePost(post.id);
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              });
                        },
                      );
                    });
            }
          },
        ));
  }
}
