class PedidoRoteiroModel {
  num? id;
  num? idRoteiroEntrega;
  num? idCliente;
  num? carregado;
  num? idStatus;
  String? status;
  String? setorEstoque;

  PedidoRoteiroModel({
    this.id,
    this.idRoteiroEntrega,
    this.idCliente,
    this.carregado,
    this.idStatus,
    this.status,
    this.setorEstoque,
  });

  PedidoRoteiroModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idRoteiroEntrega = json['idRoteiroEntrega'];
    idCliente = json['idCliente'];
    carregado = json['carregado'];
    idStatus = json['idStatus'];
    status = json['status'];
    setorEstoque = json['setorEstoque'];
  }
}
