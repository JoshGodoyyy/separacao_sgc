class RoteiroEntregaModel {
  num? id;
  String? nome;
  String? dataCriacao;
  String? dataEntrega;
  String? motorista;
  String? placa;
  num? peso;
  num? valorTotal;
  num? totalClientes;
  num? totalPedidos;
  String? dataFinalizacao;

  RoteiroEntregaModel({
    this.id,
    this.nome,
    this.dataCriacao,
    this.dataEntrega,
    this.motorista,
    this.placa,
    this.peso,
    this.valorTotal,
    this.totalClientes,
    this.totalPedidos,
    this.dataFinalizacao,
  });

  RoteiroEntregaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    dataCriacao = json['dataCriacao'];
    dataEntrega = json['dataEntrega'];
    motorista = json['motorista'];
    placa = json['placa'];
    peso = json['peso'];
    valorTotal = json['valorTotal'];
    totalClientes = json['totalClientes'];
    totalPedidos = json['totalPedidos'];
    dataFinalizacao = json['dataFinalizacao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    data['dataCriacao'] = dataCriacao;
    data['dataEntrega'] = dataEntrega;
    data['motorista'] = motorista;
    data['placa'] = placa;
    data['peso'] = peso;
    data['valorTotal'] = valorTotal;
    data['totalClientes'] = totalClientes;
    data['totalPedidos'] = totalPedidos;
    data['dataFinalizacao'] = dataFinalizacao;
    return data;
  }
}
