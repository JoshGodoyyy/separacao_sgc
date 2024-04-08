import 'dart:async';

import 'package:sgc/app/data/blocs/roteiro_entrega/roteiro_event.dart';
import 'package:sgc/app/data/blocs/roteiro_entrega/roteiro_state.dart';
import 'package:sgc/app/data/repositories/roteiro_entrega.dart';

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
    List roteiros = [];

    _outputRoteiroController.add(RoteiroLoadingState());

    if (event is GetRoteiros) {
      roteiros = await _repository.fetchRoteiros();
    } else if (event is ConcluirCarregamento) {
      roteiros = await _repository.concluirCarregamento(event.idRoteiro);
    }

    _outputRoteiroController.add(RoteiroLoadedState(roteiros: roteiros));
  }
}
