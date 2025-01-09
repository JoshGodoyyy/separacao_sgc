import 'dart:async';

import 'package:sgc/app/data/blocs/foto_pedido/foto_pedido_event.dart';
import 'package:sgc/app/data/blocs/foto_pedido/foto_pedido_state.dart';
import 'package:sgc/app/data/enums/situacao_foto.dart';
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
      if (event.fotoPedido.situacaoFoto == SituacaoFoto.separando.index) {
        final fotosSeparando = await _repository.fetchFotosSeparacao(
          int.parse(
            event.fotoPedido.idPedido.toString(),
          ),
        );

        fotos = [...fotosSeparando];
      } else if (event.fotoPedido.situacaoFoto ==
          SituacaoFoto.conferencia.index) {
        var response = await Future.wait([
          _repository.fetchFotosSeparacao(
            int.parse(
              event.fotoPedido.idPedido.toString(),
            ),
          ),
          _repository.fetchFotosConferencia(
            int.parse(
              event.fotoPedido.idPedido.toString(),
            ),
          ),
        ]);

        fotos = [...response[0], ...response[1]];
      } else if (event.fotoPedido.situacaoFoto ==
          SituacaoFoto.carregando.index) {
        var response = await Future.wait([
          _repository.fetchFotosSeparacaoCarregamento(
            int.parse(
              event.fotoPedido.idRoteiro.toString(),
            ),
            int.parse(
              event.fotoPedido.idCliente.toString(),
            ),
          ),
          _repository.fetchFotosConferenciaCarregamento(
            int.parse(
              event.fotoPedido.idRoteiro.toString(),
            ),
            int.parse(
              event.fotoPedido.idCliente.toString(),
            ),
          ),
          _repository.fetchFotosCarregando(event.fotoPedido),
        ]);

        fotos = [...response[0], ...response[1], ...response[2]];
      } else if (event.fotoPedido.situacaoFoto ==
          SituacaoFoto.carregado.index) {
        var response = await Future.wait([
          _repository.fetchFotosSeparacaoCarregado(
            int.parse(
              event.fotoPedido.idRoteiro.toString(),
            ),
          ),
          _repository.fetchFotosConferenciaCarregado(
            int.parse(
              event.fotoPedido.idRoteiro.toString(),
            ),
          ),
          _repository.fetchAllFotosCarregando(
            int.parse(
              event.fotoPedido.idRoteiro.toString(),
            ),
          ),
          _repository.fetchFotosCarregado(
            int.parse(
              event.fotoPedido.idRoteiro.toString(),
            ),
          ),
        ]);

        fotos = [
          ...response[0],
          ...response[1],
          ...response[2],
          ...response[3],
        ];
      } else if (event.fotoPedido.situacaoFoto == SituacaoFoto.entregue.index) {
        final fotosSeparando = await _repository.fetchFotosEntregue(
          int.parse(
            event.fotoPedido.idRoteiro.toString(),
          ),
        );

        fotos = [...fotosSeparando];
      } else if (event.fotoPedido.situacaoFoto ==
          SituacaoFoto.finalizado.index) {
        var response = await Future.wait([
          _repository.fetchFotosSeparacaoCarregado(
            int.parse(
              event.fotoPedido.idRoteiro.toString(),
            ),
          ),
          _repository.fetchFotosConferenciaCarregado(
            int.parse(
              event.fotoPedido.idRoteiro.toString(),
            ),
          ),
          _repository.fetchAllFotosCarregando(
            int.parse(
              event.fotoPedido.idRoteiro.toString(),
            ),
          ),
          _repository.fetchFotosCarregado(
            int.parse(
              event.fotoPedido.idRoteiro.toString(),
            ),
          ),
          _repository.fetchFotosEntregue(
            int.parse(
              event.fotoPedido.idRoteiro.toString(),
            ),
          ),
        ]);

        fotos = [
          ...response[0],
          ...response[1],
          ...response[2],
          ...response[3],
          ...response[4],
        ];
      }
    } else if (event is DeleteFoto) {
      await _repository.delete(event.foto);
    }

    _outputFotoController.add(
      FotoPedidoLoadedState(fotos: fotos),
    );
  }
}
