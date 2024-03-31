class PedidoRoteiroModel {
  num? id;
  num? idRoteiroEntrega;
  num? idCliente;
  num? carregado;

  PedidoRoteiroModel({
    this.id,
    this.idRoteiroEntrega,
    this.idCliente,
    this.carregado,
  });

  PedidoRoteiroModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idRoteiroEntrega = json['idRoteiroEntrega'];
    idCliente = json['idCliente'];
    carregado = json['carregado'];
  }
}
