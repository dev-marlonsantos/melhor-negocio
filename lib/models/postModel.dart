import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String _id = "";
  String _state = "";
  String _category = "";
  String _title = "";
  String _price = "";
  String _description = "";
  List<String>? _images;

  Post() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference posts = db.collection("my_posts");
    id = posts.doc().id;
    _images = [];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": _id,
      "state": _state,
      "category": _category,
      "title": _title,
      "price": _price,
      "description": _description,
      "images": _images
    };
    return map;
  }

  get id => _id;

  set id(value) => _id = value;

  get state => _state;

  set state(value) => _state = value;

  get category => _category;

  set category(value) => _category = value;

  get title => _title;

  set title(value) => _title = value;

  get price => _price;

  set price(value) => _price = value;

  get description => _description;

  set description(value) => _description = value;

  get images => _images;

  set images(value) => _images = value;
}
