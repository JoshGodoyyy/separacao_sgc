import 'dart:async';

import 'package:sgc/app/data/blocs/cliente/cliente_event.dart';
import 'package:sgc/app/data/blocs/cliente/cliente_state.dart';
import 'package:sgc/app/data/repositories/cliente.dart';

class ClienteBloc {
  final _repository = Cliente();

  final StreamController<ClienteEvent> _inputClienteController =
      StreamController<ClienteEvent>();
  final StreamController<ClienteState> _outputClienteController =
      StreamController<ClienteState>();

  Sink<ClienteEvent> get inputClienteController => _inputClienteController.sink;
  Stream<ClienteState> get outputClienteController =>
      _outputClienteController.stream;

  ClienteBloc() {
    _inputClienteController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(ClienteEvent event) async {
    List clientes = [];

    _outputClienteController.add(ClienteLoadingState());

    if (event is GetClientes) {
      clientes = await _repository.fetchClientes(event.idRoteiroEntrega);
    }

    _outputClienteController.add(ClienteLoadedState(clientes: clientes));
  }
}
