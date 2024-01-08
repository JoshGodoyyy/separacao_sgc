import 'dart:async';

import '../../../models/pedido_model.dart';
import '../../repositories/pedidos.dart';
import 'pedido_event.dart';
import 'pedidos_state.dart';

class PedidosBloc {
  final _repository = Pedido();

  final StreamController<PedidoEvent> _inputPedidoController =
      StreamController<PedidoEvent>();
  final StreamController<PedidosState> _outputPedidoController =
      StreamController<PedidosState>();

  Sink<PedidoEvent> get inputPedido => _inputPedidoController.sink;
  Stream<PedidosState> get outputPedido => _outputPedidoController.stream;

  PedidosBloc() {
    _inputPedidoController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(PedidoEvent event) async {
    List<PedidoModel> pedidos = [];

    _outputPedidoController.add(PedidosLoadingState());

    if (event is GetPedidosSituacao) {
      pedidos = await _repository.fetchOrdersBySituation(
          idSituacao: event.idSituacao);
    } else if (event is SearchPedido) {
      pedidos = await _repository.fetchOrdersBySituation(
          idSituacao: event.idSituacao, idPedido: event.idPedido);
    }

    _outputPedidoController.add(PedidosLoadedState(pedidos: pedidos));
  }
}
