class RoteiroEntregaModel {
  num? id;
  String? nome;
  String? dataCriacao;
  String? dataEntrega;
  String? ajudante;
  num? kmInicial;
  num? kmFinal;
  String? horaSaida;
  String? horaChegada;
  num? combustivel;
  num? pedagio;
  num? refeicao;
  num? carregamentoConcluido;
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
  String? chaveBloqueioRoteiro;

  RoteiroEntregaModel({
    this.id,
    this.nome,
    this.dataCriacao,
    this.dataEntrega,
    this.ajudante,
    this.kmInicial,
    this.kmFinal,
    this.horaSaida,
    this.horaChegada,
    this.combustivel,
    this.pedagio,
    this.refeicao,
    this.carregamentoConcluido,
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
    this.chaveBloqueioRoteiro,
  });

  RoteiroEntregaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    dataCriacao = json['dataCriacao'];
    dataEntrega = json['dataEntrega'];
    ajudante = json['ajudante'];
    kmInicial = json['kmInicial'];
    kmFinal = json['kmFinal'];
    horaSaida = json['horaSaida'];
    horaChegada = json['horaChegada'];
    combustivel = json['combustivel'];
    pedagio = json['pedagio'];
    refeicao = json['refeicao'];
    carregamentoConcluido = json['carregamentoConcluido'];
    idMotorista = json['idMotorista'];
    nomeMotorista = json['nomeMotorista'];
    idVeiculo = json['idVeiculo'];
    placa = json['placa'];
    peso = json['peso'];
    dataFinalizacao = json['dataFinalizacao'];
    valor = json['valor'];
    quantidadePedidos = json['quantidadePedidos'];
    quantidadeClientes = json['quantidadeClientes'];
    quantidadePedidosCarregados = json['quantidadePedidosCarregados'];
    chaveBloqueioRoteiro = json['chaveBloqueioRoteiro'];
  }
}
