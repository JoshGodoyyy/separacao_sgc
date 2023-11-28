class TipoEntrega {
  int? id;
  String? descricao;

  TipoEntrega({
    id,
    descricao,
  });

  TipoEntrega.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['descricao'] = descricao;

    return data;
  }
}
