import 'dart:async';

import 'package:sgc/app/data/blocs/pedido_event.dart';
import 'package:sgc/app/data/blocs/pedido_state.dart';
import 'package:sgc/app/data/repositories/pedidos.dart';

import '../../models/pedido_model.dart';

class PedidoBloc {
  final _repository = Pedidos();

  final StreamController<PedidoEvent> _inputPedidoController =
      StreamController<PedidoEvent>();
  final StreamController<PedidoState> _outputPedidoController =
      StreamController<PedidoState>();

  Sink<PedidoEvent> get inputPedido => _inputPedidoController.sink;
  Stream<PedidoState> get outputPedido => _outputPedidoController.stream;

  PedidoBloc() {
    _inputPedidoController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(PedidoEvent event) async {
    List<Pedido> pedidos = [];

    _outputPedidoController.add(PedidoLoadingState());

    if (event is GetPedidosSituacao) {
      pedidos = await _repository.fetchOrdersBySituation(event.idSituacao);
    }

    _outputPedidoController.add(PedidoLoadedState(pedidos: pedidos));
  }
}
