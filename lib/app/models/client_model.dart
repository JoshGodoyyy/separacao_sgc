class ClienteModel {
  num? id;
  String? fantasia;
  String? razaoSocial;
  num? quantidadePedidos;
  num? pedidosCarregados;
  num? posicao;

  ClienteModel(
    this.id,
    this.fantasia,
    this.razaoSocial,
    this.quantidadePedidos,
    this.pedidosCarregados,
    this.posicao,
  );

  ClienteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    razaoSocial = json['razaoSocial'];
    fantasia = json['fantasia'];
    quantidadePedidos = json['quantidadePedidos'];
    pedidosCarregados = json['pedidosCarregados'];
    posicao = json['posicao'];
  }
}
