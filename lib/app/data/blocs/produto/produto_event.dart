abstract class ProdutoEvent {}

class GetProdutos extends ProdutoEvent {
  final int tipoProduto;
  final int idPedido;

  GetProdutos({
    required this.tipoProduto,
    required this.idPedido,
  });
}

class UpdateProduto extends ProdutoEvent {
  final int idProduto;
  final int separado;
  final int tipoProduto;
  final int idPedido;

  UpdateProduto({
    required this.idProduto,
    required this.separado,
    required this.tipoProduto,
    required this.idPedido,
  });
}
