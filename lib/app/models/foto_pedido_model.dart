class FotoPedidoModel {
  num? id;
  num? situacaoFoto;
  num? idPedido;
  num? idRoteiro;
  num? idCliente;
  String? imagem;
  String? descricao;
  String? dataFoto;

  FotoPedidoModel(
    this.id,
    this.situacaoFoto,
    this.idPedido,
    this.idRoteiro,
    this.idCliente,
    this.imagem,
    this.descricao,
    this.dataFoto,
  );

  FotoPedidoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    situacaoFoto = json['situacaoFoto'];
    idPedido = json['idPedido'];
    idRoteiro = json['idRoteiro'];
    idCliente = json['idCliente'];
    imagem = json['imagem'];
    descricao = json['descricao'];
    dataFoto = json['dataFoto'];
  }
}
