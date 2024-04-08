class EnderecoRoteiroEntregaModel {
  num? id;
  String? fantasia;
  num? posicao;
  num? idFornecedor;
  num? triangulacao;
  num? entregue;
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
    this.posicao,
    this.idFornecedor,
    this.triangulacao,
    this.entregue,
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
    posicao = json['posicao'];
    idFornecedor = json['idFornecedor'];
    triangulacao = json['triangulacao'];
    entregue = json['entregue'];
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
      'idFornecedor': idFornecedor,
      'fantasia': fantasia,
      'posicao': posicao,
      'triangulacao': triangulacao,
      'entregue': entregue,
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
