abstract class ProdutoEvent {}

class GetProdutos extends ProdutoEvent {
  final int tipoProduto;
  final int idPedido;

  GetProdutos({
    required this.tipoProduto,
    required this.idPedido,
  });
}

class UpdateSeparacao extends ProdutoEvent {
  final int idProduto;
  final int separado;
  final int tipoProduto;
  final int idPedido;
  final int? idUsuarioSeparador;

  UpdateSeparacao({
    required this.idProduto,
    required this.separado,
    required this.tipoProduto,
    required this.idPedido,
    required this.idUsuarioSeparador,
  });
}

class UpdateEmbalagem extends ProdutoEvent {
  final int idProduto;
  final int embalado;
  final int tipoProduto;
  final int idPedido;

  UpdateEmbalagem({
    required this.idProduto,
    required this.embalado,
    required this.tipoProduto,
    required this.idPedido,
  });
}

class UpdateConferencia extends ProdutoEvent {
  final int idProduto;
  final int conferido;
  final int tipoProduto;
  final int idPedido;

  UpdateConferencia({
    required this.idProduto,
    required this.conferido,
    required this.tipoProduto,
    required this.idPedido,
  });
}
