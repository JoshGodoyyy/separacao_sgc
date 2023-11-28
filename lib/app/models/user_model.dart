class User {
  num? id;
  String? user;
  String? password;

  User({
    id,
    user,
    password,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['nome'];
    password = json['senha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = user;
    data['senha'] = password;

    return data;
  }
}
