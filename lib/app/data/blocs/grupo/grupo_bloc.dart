import 'dart:async';

import 'package:sgc/app/data/blocs/grupo/grupo_event.dart';
import 'package:sgc/app/data/blocs/grupo/grupo_state.dart';
import 'package:sgc/app/data/repositories/grupo.dart';

class GrupoBloc {
  final _repository = Grupo();

  final StreamController<GrupoEvent> _inputGrupoController =
      StreamController<GrupoEvent>();
  final StreamController<GrupoState> _outputGrupoController =
      StreamController<GrupoState>();

  Sink<GrupoEvent> get inputGrupo => _inputGrupoController.sink;
  Stream<GrupoState> get outputGrupo => _outputGrupoController.stream;

  GrupoBloc() {
    _inputGrupoController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(GrupoEvent event) async {
    List<dynamic> grupos = [];

    _outputGrupoController.add(GrupoLoadingState());

    if (event is GetGrupo) {
      grupos = await _repository.fetchGrupos(
        event.idPedido,
        event.idTipoProduto,
      );
    } else if (event is UpdateGrupo) {
      grupos = await _repository.updateGrupo(
        event.grupo,
        event.idPedido,
        event.tipoProduto,
      );
    }

    _outputGrupoController.add(GrupoLoadedState(grupos: grupos));
  }
}
