import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:melhor_negocio/models/postModel.dart';
import 'package:melhor_negocio/util/Configurations.dart';
import 'package:melhor_negocio/views/widgets/post_item.dart';

class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  List<String> itemsMenu = ["Meus anúncios", "Chat", "Sair"];
  List<DropdownMenuItem<String>>? _statesDropDownList;
  List<DropdownMenuItem<String>>? _categoriesDropDownList;
  String? _stateSelectedItem;
  String? _categoriesSelectedItem;
  final _controller = StreamController<QuerySnapshot>.broadcast();

  _menuItemChoise(String itemChoised) {
    switch (itemChoised) {
      case "Meus anúncios":
        Navigator.pushNamed(context, "/my-posts");
        break;
      case "Chat":
        Navigator.pushNamed(context, "/chat-list");
        break;
      case "Sair":
        _logoutUser();
        break;
    }
  }

  _logoutUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacementNamed(context, "/login");
  }

  _loadDropDownItems() {
    _categoriesDropDownList = Configurations.getCategories();
    _statesDropDownList = Configurations.getStates();
  }

  Future<Stream<QuerySnapshot>> _addListenerPosts() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    Stream<QuerySnapshot> stream = db.collection("posts").snapshots();

    stream.listen((data) {
      _controller.add(data);
    });

    throw Exception("erro");
  }

  Future<Stream<QuerySnapshot>> _postsFilter() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    Query query = db.collection("posts");
    if (_stateSelectedItem != null) {
      query = query.where("state", isEqualTo: _stateSelectedItem);
    }
    if (_categoriesSelectedItem != null) {
      query = query.where("category", isEqualTo: _categoriesSelectedItem);
    }
    Stream<QuerySnapshot> stream = query.snapshots();

    stream.listen((data) {
      _controller.add(data);
    });

    throw Exception("erro");
  }

  @override
  void initState() {
    super.initState();
    _loadDropDownItems();
    _addListenerPosts();
  }

  @override
  Widget build(BuildContext context) {
    var _loadingData = Center(
      child: Column(
        children: const <Widget>[
          Text("Carregando anúncios"),
          CircularProgressIndicator()
        ],
      ),
    );
    return Scaffold(
        appBar: AppBar(
          title: const Text("Melhor Negócio"),
          elevation: 0,
          actions: <Widget>[
            PopupMenuButton<String>(
                onSelected: _menuItemChoise,
                itemBuilder: (context) {
                  return itemsMenu.map((String item) {
                    return PopupMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList();
                })
          ],
        ),
        floatingActionButton: FloatingActionButton(
            foregroundColor: Colors.white,
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, "/new-post");
            }),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: DropdownButtonHideUnderline(
                  child: Center(
                      child: DropdownButton(
                    alignment: Alignment.centerRight,
                    iconEnabledColor: const Color(0xff9c27b0),
                    value: _stateSelectedItem,
                    items: _statesDropDownList,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    onChanged: (String? state) {
                      setState(() {
                        _stateSelectedItem = state;
                        _postsFilter();
                      });
                    },
                  )),
                )),
                Expanded(
                    child: DropdownButtonHideUnderline(
                  child: Center(
                      child: DropdownButton(
                    iconEnabledColor: const Color(0xff9c27b0),
                    value: _categoriesSelectedItem,
                    items: _categoriesDropDownList,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    onChanged: (String? category) {
                      setState(() {
                        _categoriesSelectedItem = category;
                        _postsFilter();
                      });
                    },
                  )),
                ))
              ],
            ),
            StreamBuilder(
                stream: _controller.stream,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return _loadingData;
                    case ConnectionState.active:
                    case ConnectionState.done:
                      QuerySnapshot? querySnapshot =
                          snapshot.data as QuerySnapshot<Object?>?;
                      if (querySnapshot == null) {
                        return Container(
                            padding: const EdgeInsets.all(25),
                            child: const Text("Nenhum anúncio!",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)));
                      }
                      return Expanded(
                          child: ListView.builder(
                              itemCount: querySnapshot.docs.length,
                              itemBuilder: (_, indice) {
                                List<DocumentSnapshot> posts =
                                    querySnapshot.docs.toList();
                                DocumentSnapshot documentSnapshot =
                                    posts[indice];
                                Post post =
                                    Post.fromDocumentSnapshot(documentSnapshot);
                                return PostItem(
                                  post: post,
                                  onTapItem: () {
                                    Navigator.pushNamed(
                                        context, "/post-details",
                                        arguments: post);
                                  },
                                );
                              }));
                  }
                })
          ],
        ));
  }
}
