import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:intl/intl.dart';

class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  List<String> itemsMenu = ["Meus anúncios", "Sair"];
  _menuItemChoise(String itemChoised) {
    switch (itemChoised) {
      case "Meus anúncios":
        Navigator.pushNamed(context, "/my-posts");
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

  @override
  Widget build(BuildContext context) {
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
      body: const Text("Anúncios"),
    );
  }
}
