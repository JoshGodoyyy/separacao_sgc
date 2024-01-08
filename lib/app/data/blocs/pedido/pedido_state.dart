import '../../../models/pedido_model.dart';

abstract class PedidoState {
  final PedidoModel? pedido;

  PedidoState({required this.pedido});
}

class PedidoInitialState extends PedidoState {
  PedidoInitialState() : super(pedido: null);
}

class PedidoLoadingState extends PedidoState {
  PedidoLoadingState() : super(pedido: null);
}

class PedidoLoadedState extends PedidoState {
  PedidoLoadedState({required PedidoModel pedido}) : super(pedido: pedido);
}

class PedidoErrorState extends PedidoState {
  final String exception;

  PedidoErrorState({required this.exception}) : super(pedido: null);
}
