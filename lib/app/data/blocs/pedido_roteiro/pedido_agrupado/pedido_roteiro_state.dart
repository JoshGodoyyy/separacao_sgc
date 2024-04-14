import 'package:sgc/app/models/pedido_roteiro_model.dart';

abstract class ProdutoRoteiroState {
  final PedidoRoteiroModel? pedido;

  ProdutoRoteiroState({required this.pedido});
}

class ProdutoRoteiroInitialState extends ProdutoRoteiroState {
  ProdutoRoteiroInitialState() : super(pedido: null);
}

class ProdutoRoteiroLoadingState extends ProdutoRoteiroState {
  ProdutoRoteiroLoadingState() : super(pedido: null);
}

class ProdutoRoteiroLoadedState extends ProdutoRoteiroState {
  ProdutoRoteiroLoadedState({required super.pedido});
}

class ProdutoRoteiroErrorState extends ProdutoRoteiroState {
  final String exception;

  ProdutoRoteiroErrorState({required this.exception}) : super(pedido: null);
}
