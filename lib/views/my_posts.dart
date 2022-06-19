import 'package:flutter/material.dart';
import 'package:melhor_negocio/views/widgets/post_item.dart';

class MyPosts extends StatefulWidget {
  const MyPosts({Key? key}) : super(key: key);

  @override
  State<MyPosts> createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  @override
  Widget build(BuildContext context) {
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
        body: ListView.builder(
            itemCount: 8,
            itemBuilder: (_, indice) {
              return const PostItem();
            }));
  }
}
