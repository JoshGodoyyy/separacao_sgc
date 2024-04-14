import 'dart:async';

import 'package:sgc/app/models/pedido_roteiro_model.dart';

import '../../../repositories/pedido_roteiro.dart';
import 'pedido_roteiro_event.dart';
import 'pedido_roteiro_state.dart';

class PedidoRoteiroGroupBloc {
  final _repository = PedidoRoteiro();

  final StreamController<PedidoRoteiroEvent> _inputProdutoRoteiroController =
      StreamController<PedidoRoteiroEvent>();
  final StreamController<ProdutoRoteiroState> _outputProdutoRoteiroController =
      StreamController<ProdutoRoteiroState>();

  Sink<PedidoRoteiroEvent> get inputProdutoRoteiroController =>
      _inputProdutoRoteiroController.sink;
  Stream<ProdutoRoteiroState> get outputProdutoRoteiroController =>
      _outputProdutoRoteiroController.stream;

  PedidoRoteiroGroupBloc() {
    _inputProdutoRoteiroController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(PedidoRoteiroEvent event) async {
    PedidoRoteiroModel pedido = PedidoRoteiroModel();

    _outputProdutoRoteiroController.add(ProdutoRoteiroLoadingState());

    if (event is GetPedido) {
      pedido = await _repository.fetchPedido(event.idPedido);
    }

    _outputProdutoRoteiroController
        .add(ProdutoRoteiroLoadedState(pedido: pedido));
  }
}
