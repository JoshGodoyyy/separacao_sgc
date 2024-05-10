abstract class ProdutosEstoqueState {
  final List<dynamic> produtosEstoque;

  ProdutosEstoqueState({required this.produtosEstoque});
}

class ProdutosEstoqueInitialState extends ProdutosEstoqueState {
  ProdutosEstoqueInitialState() : super(produtosEstoque: []);
}

class ProdutosEstoqueLoadingState extends ProdutosEstoqueState {
  ProdutosEstoqueLoadingState() : super(produtosEstoque: []);
}

class ProdutosEstoqueLoadedState extends ProdutosEstoqueState {
  ProdutosEstoqueLoadedState({required super.produtosEstoque});
}

class ProdutosEstoqueErrorState extends ProdutosEstoqueState {
  final String exception;

  ProdutosEstoqueErrorState({required this.exception})
      : super(produtosEstoque: []);
}
