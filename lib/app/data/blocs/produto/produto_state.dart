abstract class ProdutoState {
  final List<dynamic> produtos;

  ProdutoState({required this.produtos});
}

class ProdutoInitialState extends ProdutoState {
  ProdutoInitialState() : super(produtos: []);
}

class ProdutoLoadingState extends ProdutoState {
  ProdutoLoadingState() : super(produtos: []);
}

class ProdutoLoadedState extends ProdutoState {
  ProdutoLoadedState({required List<dynamic> produtos})
      : super(produtos: produtos);
}

class ProdutoErrorState extends ProdutoState {
  final String exception;

  ProdutoErrorState({required this.exception}) : super(produtos: []);
}
