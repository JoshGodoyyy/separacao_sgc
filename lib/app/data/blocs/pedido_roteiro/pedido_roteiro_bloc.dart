import 'dart:async';

import 'package:sgc/app/data/blocs/pedido_roteiro/pedido_roteiro_event.dart';
import 'package:sgc/app/data/blocs/pedido_roteiro/pedido_roteiro_state.dart';
import 'package:sgc/app/data/repositories/pedido_roteiro.dart';

class PedidoRoteiroBloc {
  final _repository = PedidoRoteiro();

  final StreamController<PedidoRoteiroEvent> _inputProdutoRoteiroController =
      StreamController<PedidoRoteiroEvent>();
  final StreamController<ProdutoRoteiroState> _outputProdutoRoteiroController =
      StreamController<ProdutoRoteiroState>();

  Sink<PedidoRoteiroEvent> get inputProdutoRoteiroController =>
      _inputProdutoRoteiroController.sink;
  Stream<ProdutoRoteiroState> get outputProdutoRoteiroController =>
      _outputProdutoRoteiroController.stream;

  PedidoRoteiroBloc() {
    _inputProdutoRoteiroController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(PedidoRoteiroEvent event) async {
    List pedidos = [];

    _outputProdutoRoteiroController.add(ProdutoRoteiroLoadingState());

    if (event is GetPedidosNaoCarregados) {
      pedidos = await _repository.fetchPedidosNaoCarregados(
        event.numeroEntrega,
        event.cepEntrega,
        event.idCliente,
        event.idRoteiro,
        event.separarAgrupamento,
      );
    } else if (event is GetPedidosCarregados) {
      pedidos = await _repository.fetchPedidosCarregados(
        event.numeroEntrega,
        event.cepEntrega,
        event.idCliente,
        event.idRoteiro,
        event.separarAgrupamento,
      );
    } else if (event is CarregarPedido) {
      pedidos = await _repository.carregarPedido(
        event.idPedido,
        event.numeroEntrega,
        event.cepEntrega,
        event.idCliente,
        event.idRoteiro,
        event.separarAgrupamento,
      );
    } else if (event is DescarregarPedido) {
      pedidos = await _repository.descarregarPedido(
        event.idPedido,
        event.numeroEntrega,
        event.cepEntrega,
        event.idCliente,
        event.idRoteiro,
        event.separarAgrupamento,
      );
    }

    _outputProdutoRoteiroController
        .add(ProdutoRoteiroLoadedState(produtos: pedidos));
  }
}
