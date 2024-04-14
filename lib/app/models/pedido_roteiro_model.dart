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
  }
}
