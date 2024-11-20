import 'dart:async';

import 'package:sgc/app/data/blocs/foto_pedido/foto_pedido_event.dart';
import 'package:sgc/app/data/blocs/foto_pedido/foto_pedido_state.dart';
import 'package:sgc/app/data/repositories/foto_pedido.dart';

class FotoPedidoBloc {
  final _repository = FotoPedido();

  final StreamController<FotoPedidoEvent> _inputFotoController =
      StreamController<FotoPedidoEvent>();
  final StreamController<FotoPedidoState> _outputFotoController =
      StreamController<FotoPedidoState>();

  Sink<FotoPedidoEvent> get inputFoto => _inputFotoController.sink;
  Stream<FotoPedidoState> get outputFoto => _outputFotoController.stream;

  FotoPedidoBloc() {
    _inputFotoController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(FotoPedidoEvent event) async {
    List<dynamic> fotos = [];

    _outputFotoController.add(FotoPedidoLoadingState());

    if (event is GetFotos) {
      fotos = await _repository.fetchFotos(event.fotoPedido);
    } else if (event is DeleteFoto) {
      fotos = await _repository.delete(event.foto);
    }

    _outputFotoController.add(
      FotoPedidoLoadedState(fotos: fotos),
    );
  }
}
