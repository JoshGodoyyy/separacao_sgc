class User {
  num? id;
  String? user;
  String? password;
  String? apelido;
  String? idLiberacao;

  User({
    id,
    user,
    password,
    apelido,
    idLiberacao,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['nome'];
    password = json['senha'];
    apelido = json['apelido'];
    idLiberacao = json['idLiberacao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = user;
    data['senha'] = password;
    data['apelido'] = apelido;
    data['idLiberacao'] = idLiberacao;

    return data;
  }
}
