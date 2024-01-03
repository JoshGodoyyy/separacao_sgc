import 'dart:async';

import '../../../models/pedido_model.dart';
import '../../repositories/pedidos.dart';
import 'pedido_event.dart';
import 'pedido_state.dart';

class PedidoBloc {
  final _repository = Pedido();

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
    List<PedidoModel> pedidos = [];

    _outputPedidoController.add(PedidoLoadingState());

    if (event is GetPedidosSituacao) {
      pedidos = await _repository.fetchOrdersBySituation(
          idSituacao: event.idSituacao);
    }
    if (event is SearchPedido) {
      pedidos = await _repository.fetchOrdersBySituation(
          idSituacao: event.idSituacao, idPedido: event.idPedido);
    }

    _outputPedidoController.add(PedidoLoadedState(pedidos: pedidos));
  }
}
