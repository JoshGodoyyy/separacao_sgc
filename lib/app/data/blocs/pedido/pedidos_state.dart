import '../../../models/pedido_model.dart';

abstract class PedidosState {
  final List<PedidoModel> pedidos;

  PedidosState({required this.pedidos});
}

class PedidosInitialState extends PedidosState {
  PedidosInitialState() : super(pedidos: []);
}

class PedidosLoadingState extends PedidosState {
  PedidosLoadingState() : super(pedidos: []);
}

class PedidosLoadedState extends PedidosState {
  PedidosLoadedState({required super.pedidos});
}

class PedidosErrorState extends PedidosState {
  final String exception;

  PedidosErrorState({required this.exception}) : super(pedidos: []);
}
