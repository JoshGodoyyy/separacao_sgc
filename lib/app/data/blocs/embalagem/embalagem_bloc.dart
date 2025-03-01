import 'dart:async';

import 'package:sgc/app/data/blocs/embalagem/embalagem_event.dart';
import 'package:sgc/app/data/blocs/embalagem/embalagem_state.dart';
import 'package:sgc/app/data/repositories/embalagem.dart';

class EmbalagemBloc {
  final _repository = Embalagem();

  final StreamController<EmbalagemEvent> _inputEmbalagemController =
      StreamController<EmbalagemEvent>();
  final StreamController<EmbalagemState> _outputEmbalagemController =
      StreamController<EmbalagemState>();

  Sink<EmbalagemEvent> get inputEmbalagem => _inputEmbalagemController.sink;
  Stream<EmbalagemState> get outputEmbalagem =>
      _outputEmbalagemController.stream;

  EmbalagemBloc() {
    _inputEmbalagemController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(EmbalagemEvent event) async {
    List<dynamic> embalagens = [];

    _outputEmbalagemController.add(EmbalagemLoadingState());

    if (event is GetEmbalagens) {
      embalagens = await _repository.fetchEmbalagens(event.idPedido);
    } else if (event is PostEmbalagem) {
      embalagens = await _repository.insertEmbalagem(event.embalagem);
    } else if (event is UpdateEmbalagem) {
      embalagens = await _repository.updateEmbalagem(event.embalagem);
    } else if (event is DeleteEmbalagem) {
      embalagens = await _repository.deleteEmbalagem(event.embalagem);
    }

    _outputEmbalagemController
        .add(EmbalagemLoadedState(embalagens: embalagens));
  }
}
