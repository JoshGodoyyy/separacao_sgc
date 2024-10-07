class User {
  num? id;
  String? user;
  String? password;
  String? apelido;
  String? idLiberacao;
  String? nivelSenha;

  User({
    id,
    user,
    password,
    apelido,
    idLiberacao,
    this.nivelSenha,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['nome'];
    password = json['senha'];
    apelido = json['apelido'];
    idLiberacao = json['idLiberacao'];
    nivelSenha = json['nivelSenha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = user;
    data['senha'] = password;
    data['apelido'] = apelido;
    data['idLiberacao'] = idLiberacao;
    data['nivelSenha'] = nivelSenha;

    return data;
  }
}
