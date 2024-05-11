class ClienteModel {
  num? id;
  String? fantasia;
  String? razaoSocial;
  num? posicao;
  num? quantidadePedidos;
  num? pedidosAgrupados;
  num? pedidosCarregados;
  num? idCliente;
  num? idSituacao;
  String? logradouro;
  String? endereco;
  String? numero;
  String? complemento;
  String? bairro;
  String? cidade;
  String? estado;
  String? cep;

  ClienteModel(
    this.id,
    this.fantasia,
    this.razaoSocial,
    this.posicao,
    this.quantidadePedidos,
    this.pedidosAgrupados,
    this.pedidosCarregados,
    this.idCliente,
    this.idSituacao,
    this.logradouro,
    this.endereco,
    this.numero,
    this.complemento,
    this.bairro,
    this.cidade,
    this.cep,
  );

  ClienteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fantasia = json['fantasia'];
    razaoSocial = json['razaoSocial'];
    posicao = json['posicao'];
    quantidadePedidos = json['quantidadePedidos'];
    pedidosAgrupados = json['pedidosAgrupados'];
    pedidosCarregados = json['pedidosCarregados'];
    idCliente = json['idCliente'];
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
}
