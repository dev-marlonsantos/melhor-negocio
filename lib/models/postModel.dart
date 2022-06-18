class Post {
  String _id = "";
  String _state = "";
  String _category = "";
  String _title = "";
  String _price = "";
  String _description = "";
  List<String> _images = [];

  Post();

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
