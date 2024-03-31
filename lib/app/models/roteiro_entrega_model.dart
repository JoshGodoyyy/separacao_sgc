class RoteiroEntregaModel {
  num? id;
  String? nome;
  String? dataCriacao;
  String? dataEntrega;
  num? idMotorista;
  String? nomeMotorista;
  num? idVeiculo;
  String? placa;
  num? peso;
  String? dataFinalizacao;
  num? valor;
  num? quantidadePedidos;
  num? quantidadeClientes;
  num? quantidadePedidosCarregados;

  RoteiroEntregaModel({
    this.id,
    this.nome,
    this.dataCriacao,
    this.dataEntrega,
    this.idMotorista,
    this.nomeMotorista,
    this.idVeiculo,
    this.placa,
    this.peso,
    this.dataFinalizacao,
    this.valor,
    this.quantidadePedidos,
    this.quantidadeClientes,
    this.quantidadePedidosCarregados,
  });

  RoteiroEntregaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    dataCriacao = json['dataCriacao'];
    dataEntrega = json['dataEntrega'];
    idMotorista = json['idMotorista'];
    nomeMotorista = json['nomeMotorista'];
    idVeiculo = json['idVeiculo'];
    placa = json['placa'];
    peso = json['peso'];
    valor = json['valor'];
    dataFinalizacao = json['dataFinalizacao'];
    quantidadeClientes = json['quantidadeClientes'];
    quantidadePedidos = json['quantidadePedidos'];
    quantidadePedidosCarregados = json['quantidadePedidosCarregados'];
  }
}
