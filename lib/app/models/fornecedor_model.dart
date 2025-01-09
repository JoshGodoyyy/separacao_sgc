class FornecedorModel {
  String? fantasia;
  String? logradouro;
  String? nomeRua;
  String? numero;
  String? complemento;
  String? bairro;
  String? cidade;
  String? estado;
  String? cep;

  FornecedorModel({
    this.fantasia,
    this.logradouro,
    this.nomeRua,
    this.numero,
    this.complemento,
    this.bairro,
    this.cidade,
    this.estado,
    this.cep,
  });

  FornecedorModel.fromJson(Map<String, dynamic> json) {
    fantasia = json['fantasia'];
    logradouro = json['logradouro'];
    nomeRua = json['nomeRua'];
    numero = json['numero'];
    complemento = json['complemento'];
    bairro = json['bairro'];
    cidade = json['cidade'];
    estado = json['estado'];
    cep = json['cep'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['logradouro'] = logradouro;
    data['nomeRua'] = nomeRua;
    data['numero'] = numero;
    data['complemento'] = complemento;
    data['bairro'] = bairro;
    data['cidade'] = cidade;
    data['estado'] = estado;
    data['cep'] = cep;

    return data;
  }
}
