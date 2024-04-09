import 'dart:async';

import 'package:sgc/app/data/blocs/dados_roteiro_entrega/roteiro_event.dart';
import 'package:sgc/app/data/blocs/dados_roteiro_entrega/roteiro_state.dart';
import 'package:sgc/app/models/roteiro_entrega_model.dart';

import '../../repositories/roteiro_entrega.dart';

class RoteiroBloc {
  final _repository = RoteiroEntrega();

  final StreamController<RoteiroEvent> _inputRoteiroController =
      StreamController<RoteiroEvent>();
  final StreamController<RoteiroState> _outputRoteiroController =
      StreamController<RoteiroState>();

  Sink<RoteiroEvent> get inputRoteiroController => _inputRoteiroController.sink;
  Stream<RoteiroState> get outputRoteiroController =>
      _outputRoteiroController.stream;

  RoteiroBloc() {
    _inputRoteiroController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(RoteiroEvent event) async {
    var roteiro = RoteiroEntregaModel();

    _outputRoteiroController.add(RoteiroLoadingState());

    if (event is GetRoteiro) {
      roteiro = await _repository.fetchDados(event.idRoteiro);
    } else if (event is UpdateDados) {
      roteiro = await _repository.updateDados(
        event.idRoteiro,
        event.kmInicial,
        event.ajudante,
        event.horarioSaida,
      );
    } else if (event is FinishDados) {
      roteiro = await _repository.finishDados(
        event.idRoteiro,
        event.pedagio,
        event.combustivel,
        event.refeicao,
        event.kmFinal,
      );
    }

    _outputRoteiroController.add(RoteiroLoadedState(roteiro: roteiro));
  }
}
