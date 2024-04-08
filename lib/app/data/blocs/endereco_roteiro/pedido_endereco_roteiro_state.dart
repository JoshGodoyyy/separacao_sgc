abstract class PedidoEnderecoRoteiroState {
  final List pedidos;

  PedidoEnderecoRoteiroState({required this.pedidos});
}

class PedidoEnderecoRoteiroInitialState extends PedidoEnderecoRoteiroState {
  PedidoEnderecoRoteiroInitialState() : super(pedidos: []);
}

class PedidoEnderecoRoteiroLoadingState extends PedidoEnderecoRoteiroState {
  PedidoEnderecoRoteiroLoadingState() : super(pedidos: []);
}

class PedidoEnderecoRoteiroLoadedState extends PedidoEnderecoRoteiroState {
  PedidoEnderecoRoteiroLoadedState({required super.pedidos});
}

class PedidoEnderecoRoteiroErrorState extends PedidoEnderecoRoteiroState {
  final String exception;

  PedidoEnderecoRoteiroErrorState({required this.exception})
      : super(pedidos: []);
}
