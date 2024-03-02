class SituacaoPedidoModel {
  num? id;
  String? descricao;

  SituacaoPedidoModel(
    id,
    descricao,
  );

  SituacaoPedidoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
  }
}
