import 'dart:async';

import 'package:sgc/app/data/blocs/endereco_roteiro/endereco_roteiro_event.dart';
import 'package:sgc/app/data/blocs/endereco_roteiro/pedido_endereco_roteiro_state.dart';
import 'package:sgc/app/data/repositories/endereco_roteiro_entrega.dart';

class PedidoEnderecoRoteiroBloc {
  final _repository = EnderecoRoteiroEntrega();

  final StreamController<EnderecoRoteiroEvent> _inputEnderecoController =
      StreamController<EnderecoRoteiroEvent>();
  final StreamController<PedidoEnderecoRoteiroState> _outputEnderecoController =
      StreamController<PedidoEnderecoRoteiroState>();

  Sink<EnderecoRoteiroEvent> get inputRoteiroEntregaController =>
      _inputEnderecoController.sink;
  Stream<PedidoEnderecoRoteiroState> get outputRoteiroEntregaController =>
      _outputEnderecoController.stream;

  PedidoEnderecoRoteiroBloc() {
    _inputEnderecoController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(EnderecoRoteiroEvent event) async {
    List pedidos = [];

    _outputEnderecoController.add(PedidoEnderecoRoteiroLoadingState());

    if (event is GetPedidos) {
      pedidos = await _repository.fetchPedidos(
        event.cep,
        event.numero,
        event.idRoteiro,
      );
    }

    _outputEnderecoController
        .add(PedidoEnderecoRoteiroLoadedState(pedidos: pedidos));
  }
}
