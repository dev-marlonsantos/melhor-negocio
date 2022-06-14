class User {
  String idUser = "";
  String name = "";
  String email = "";
  String password = "";
  String imageUrl = "";
  String phone = "";

  User();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "idUser": idUser,
      "name": name,
      "email": email,
      "imageUrl": imageUrl,
      "phone": phone
    };
    return map;
  }
}
