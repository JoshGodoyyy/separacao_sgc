class FotoPedidoModel {
  num? id;
  num? situacaoFoto;
  num? idPedido;
  num? idRoteiro;
  String? nomeRoteiro;
  num? idCliente;
  String? nomeCliente;
  String? imagem;
  String? descricao;
  String? dataFoto;

  FotoPedidoModel(
    this.id,
    this.situacaoFoto,
    this.idPedido,
    this.idRoteiro,
    this.idCliente,
    this.nomeCliente,
    this.imagem,
    this.descricao,
    this.dataFoto,
  );

  FotoPedidoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    situacaoFoto = json['situacaoFoto'];
    idPedido = json['idPedido'];
    idRoteiro = json['idRoteiro'];
    nomeRoteiro = json['nomeRoteiro'];
    idCliente = json['idCliente'];
    nomeCliente = json['nomeCliente'];
    imagem = json['imagem'];
    descricao = json['descricao'];
    dataFoto = json['dataFoto'];
  }
}
