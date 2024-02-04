import 'dart:async';

import 'package:sgc/app/data/blocs/pedido/pedido_event.dart';
import 'package:sgc/app/data/blocs/pedido/pedido_state.dart';
import 'package:sgc/app/data/repositories/pedido.dart';
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

    if (event is UpdatePedido) {
      pedido = await _repository.updateOrder(
        event.idPedido,
        event.volAcessorio,
        event.volAlum,
        event.volChapa,
        event.obsSeparacao,
        event.obsSeparador,
        event.setorEstoque,
        event.pesoAcessorio,
      );
    } else if (event is EnviarSeparacao) {
      pedido = await _repository.enviarSeparacao(
        event.idSituacao,
        event.dataLiberacaoSeparacao,
        event.dataEnvioSeparacao,
        event.idIniciarSeparacao,
        event.sepAcessorio,
        event.sepPerfil,
        event.id,
      );
    } else if (event is EnviarEmbalagem) {
      pedido = await _repository.enviarEmbalagem(
        event.idSituacao,
        event.sepAcessorio,
        event.sepPerfil,
        event.idSeparador,
        event.dataRetornoSeparacao,
        event.observacoesSeparacao,
        event.idConcluirSeparacao,
        event.id,
        event.tipoProduto,
      );
    } else if (event is LiberarConferencia) {
      pedido = await _repository.liberarConferencia(
        event.idSituacao,
        event.observacoesSeparacao,
        event.id,
      );
    } else if (event is FinalizarSeparacao) {
      pedido = await _repository.finalizarSeparacao(
        event.idSituacao,
        event.observacoesSeparacao,
        event.volumePerfil,
        event.volumeAcessorio,
        event.volumeChapa,
        event.pesoTotalTeorico,
        event.pesoTotalReal,
        event.valorTotalTeorico,
        event.valorTotalReal,
        event.sepAcessorio,
        event.sepPerfil,
        event.idSeparador,
        event.chaveLiberacao,
        event.id,
      );
    }

    _outputPedidoController.add(PedidoLoadedState(pedido: pedido!));
  }
}
