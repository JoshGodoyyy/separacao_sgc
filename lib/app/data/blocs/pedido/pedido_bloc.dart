import 'dart:async';

import 'package:sgc/app/data/blocs/pedido/pedido_event.dart';
import 'package:sgc/app/data/blocs/pedido/pedido_state.dart';
import 'package:sgc/app/data/repositories/pedidos.dart';
import 'package:sgc/app/models/pedido_model.dart';

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
    PedidoModel? pedido;

    _outputPedidoController.add(PedidoLoadingState());

    if (event is PostPedido) {
      pedido = await _repository.updateOrder(event.pedido);
    }

    _outputPedidoController.add(PedidoLoadedState(pedido: pedido!));
  }
}
