import 'package:flutter/material.dart';
import 'package:melhor_negocio/models/post_model.dart';

// ignore: must_be_immutable
class PostItem extends StatelessWidget {
  Post? post;
  VoidCallback? onTapItem;
  VoidCallback? onPressedRemove;

  PostItem(
      {Key? key, @required this.post, this.onTapItem, this.onPressedRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapItem,
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(children: <Widget>[
          SizedBox(
            width: 120,
            height: 120,
            child: Image.network(
              post!.images[0],
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(post!.title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("${post!.price}"),
                  ]),
            ),
          ),
          if (onPressedRemove != null)
            Expanded(
                flex: 1,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  onPressed: onPressedRemove,
                  child: const Icon(Icons.delete, color: Colors.white),
                ))
        ]),
      )),
    );
  }
}
