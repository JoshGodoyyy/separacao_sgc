class ConfiguracoesModel {
  num? id;
  num? chaveFuncionario;

  ConfiguracoesModel({this.id, this.chaveFuncionario});

  ConfiguracoesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chaveFuncionario = json['chaveFuncionario'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['chaveFuncionario'] = chaveFuncionario;
    return data;
  }
}
