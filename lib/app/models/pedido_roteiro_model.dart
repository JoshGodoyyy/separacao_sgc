class PedidoRoteiroModel {
  num? id;
  num? idRoteiroEntrega;
  num? volumeAcessorio;
  num? volumeChapa;
  num? volumePerfil;
  num? idCliente;
  num? carregado;
  num? idStatus;
  String? status;
  String? setorEstoque;
  String? pedidosAgrupados;
  bool? selecionado;
  num? pesoTotal;
  String? tratamento;
  String? tratamentoItens;
  String? observacoesCarregador;

  PedidoRoteiroModel({
    this.id,
    this.idRoteiroEntrega,
    this.volumeAcessorio,
    this.volumeChapa,
    this.volumePerfil,
    this.idCliente,
    this.carregado,
    this.idStatus,
    this.status,
    this.setorEstoque,
    this.pedidosAgrupados,
    this.selecionado,
    this.pesoTotal,
    this.tratamento,
    this.tratamentoItens,
    this.observacoesCarregador,
  });

  PedidoRoteiroModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idRoteiroEntrega = json['idRoteiroEntrega'];
    volumeAcessorio = json['volumeAcessorio'];
    volumeChapa = json['volumeChapa'];
    volumePerfil = json['volumePerfil'];
    idCliente = json['idCliente'];
    carregado = json['carregado'];
    idStatus = json['idStatus'];
    status = json['status'];
    setorEstoque = json['setorEstoque'];
    pedidosAgrupados = json['pedidosAgrupados'];
    pesoTotal = json['pesoTotal'];
    tratamento = json['tratamento'];
    tratamentoItens = json['tratamentoItens'];
    observacoesCarregador = json['observacoesCarregador'];
  }
}
