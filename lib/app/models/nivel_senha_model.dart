class NivelSenhaModel {
  String? nivel;
  num? idUsuario;

  NivelSenhaModel({
    this.nivel,
    this.idUsuario,
  });

  NivelSenhaModel.fromJson(Map<String, dynamic> json) {
    idUsuario = json['idUsuario'];
    nivel = json['nivel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idUsuario'] = idUsuario;
    data['nivel'] = nivel;
    return data;
  }
}
