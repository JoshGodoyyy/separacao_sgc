abstract class FotoPedidoState {
  final List<dynamic> fotos;

  FotoPedidoState({required this.fotos});
}

class FotoPedidoInitialState extends FotoPedidoState {
  FotoPedidoInitialState() : super(fotos: []);
}

class FotoPedidoLoadingState extends FotoPedidoState {
  FotoPedidoLoadingState() : super(fotos: []);
}

class FotoPedidoLoadedState extends FotoPedidoState {
  FotoPedidoLoadedState({required super.fotos});
}

class FotoPedidoErrorState extends FotoPedidoState {
  final String exception;
  FotoPedidoErrorState({required this.exception}) : super(fotos: []);
}
