class FotoPedidoModel {
  num? id;
  num? situacaoFoto;
  num? idPedido;
  num? idRoteiro;
  String? imagem;
  String? descricao;
  String? dataFoto;

  FotoPedidoModel(
    this.id,
    this.situacaoFoto,
    this.idPedido,
    this.idRoteiro,
    this.imagem,
    this.descricao,
    this.dataFoto,
  );

  FotoPedidoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    situacaoFoto = json['situacaoFoto'];
    idPedido = json['idPedido'];
    idRoteiro = json['idRoteiro'];
    imagem = json['imagem'];
    descricao = json['descricao'];
    dataFoto = json['dataFoto'];
  }
}
