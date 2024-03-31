abstract class ClienteState {
  final List clientes;

  ClienteState({required this.clientes});
}

class ClienteInitialState extends ClienteState {
  ClienteInitialState() : super(clientes: []);
}

class ClienteLoadingState extends ClienteState {
  ClienteLoadingState() : super(clientes: []);
}

class ClienteLoadedState extends ClienteState {
  ClienteLoadedState({required super.clientes});
}

class ClienteErrorState extends ClienteState {
  final String exception;

  ClienteErrorState({required this.exception}) : super(clientes: []);
}
