class HistoricoPedidoModel {
  num? id;
  num? idPedido;
  num? idStatus;
  String? status;
  num? idUsuario;
  String? nomeUsuario;
  String? data;
  String? chaveFuncionario;

  HistoricoPedidoModel({
    this.id,
    this.idPedido,
    this.idStatus,
    this.status,
    this.idUsuario,
    this.nomeUsuario,
    this.data,
    this.chaveFuncionario,
  });

  HistoricoPedidoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idPedido = json['idPedido'];
    idStatus = json['idStatus'];
    status = json['status'];
    idUsuario = json['idUsuario'];
    nomeUsuario = json['nomeUsuario'];
    data = json['data'];
    chaveFuncionario = json['chaveFuncionario'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id ?? 0;
    data['idPedido'] = idPedido ?? 0;
    data['idStatus'] = idStatus ?? 0;
    data['status'] = status ?? '';
    data['idUsuario'] = idUsuario ?? 0;
    data['nomeUsuario'] = nomeUsuario ?? '';
    data['data'] = this.data;
    data['chaveFuncionario'] = chaveFuncionario ?? '';
    return data;
  }
}
