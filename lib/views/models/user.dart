class User {
  String idUser = "";
  String name = "";
  String email = "";
  String password = "";

  User();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {"idUser": idUser, "name": name, "email": email};
    return map;
  }
}
