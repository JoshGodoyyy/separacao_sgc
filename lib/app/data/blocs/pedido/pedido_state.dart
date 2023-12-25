import '../../../models/pedido_model.dart';

abstract class PedidoState {
  final List<PedidoModel> pedidos;

  PedidoState({required this.pedidos});
}

class PedidoInitialState extends PedidoState {
  PedidoInitialState() : super(pedidos: []);
}

class PedidoLoadingState extends PedidoState {
  PedidoLoadingState() : super(pedidos: []);
}

class PedidoLoadedState extends PedidoState {
  PedidoLoadedState({required List<PedidoModel> pedidos})
      : super(pedidos: pedidos);
}

class PedidoErrorState extends PedidoState {
  final String exception;

  PedidoErrorState({required this.exception}) : super(pedidos: []);
}
