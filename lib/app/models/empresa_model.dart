class EmpresaModel {
  String? nome;
  String? telefone;

  EmpresaModel({
    this.nome,
    this.telefone,
  });

  EmpresaModel.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    telefone = json['telefone'];
  }
}
