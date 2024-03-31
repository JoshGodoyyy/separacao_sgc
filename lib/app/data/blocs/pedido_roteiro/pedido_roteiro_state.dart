abstract class ProdutoRoteiroState {
  final List produtos;

  ProdutoRoteiroState({required this.produtos});
}

class ProdutoRoteiroInitialState extends ProdutoRoteiroState {
  ProdutoRoteiroInitialState() : super(produtos: []);
}

class ProdutoRoteiroLoadingState extends ProdutoRoteiroState {
  ProdutoRoteiroLoadingState() : super(produtos: []);
}

class ProdutoRoteiroLoadedState extends ProdutoRoteiroState {
  ProdutoRoteiroLoadedState({required super.produtos});
}

class ProdutoRoteiroErrorState extends ProdutoRoteiroState {
  final String exception;

  ProdutoRoteiroErrorState({required this.exception}) : super(produtos: []);
}
