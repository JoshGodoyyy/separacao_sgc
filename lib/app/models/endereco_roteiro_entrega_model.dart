class EnderecoRoteiroEntregaModel {
  num? id;
  String? fantasia;
  String? razaoSocial;
  num? posicao;
  num? idSituacao;
  String? logradouro;
  String? endereco;
  String? numero;
  String? complemento;
  String? bairro;
  String? cidade;
  String? estado;
  String? cep;

  EnderecoRoteiroEntregaModel({
    this.id,
    this.fantasia,
    this.razaoSocial,
    this.posicao,
    this.idSituacao,
    this.logradouro,
    this.endereco,
    this.numero,
    this.complemento,
    this.bairro,
    this.cidade,
    this.estado,
    this.cep,
  });

  EnderecoRoteiroEntregaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fantasia = json['fantasia'];
    razaoSocial = json['razaoSocial'];
    posicao = json['posicao'];
    idSituacao = json['idSituacao'];
    logradouro = json['logradouro'];
    endereco = json['endereco'];
    numero = json['numero'];
    complemento = json['complemento'];
    bairro = json['bairro'];
    cidade = json['cidade'];
    estado = json['estado'];
    cep = json['cep'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fantasia': fantasia,
      'razaoSocial': razaoSocial,
      'posicao': posicao,
      'idSituacao': idSituacao,
      'logradouro': logradouro,
      'endereco': endereco,
      'numero': numero,
      'complemento': complemento,
      'bairro': bairro,
      'cidade': cidade,
      'estado': estado,
      'cep': cep,
    };
  }
}
