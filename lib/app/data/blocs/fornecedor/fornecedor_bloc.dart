import 'dart:async';

import 'package:sgc/app/data/blocs/fornecedor/fornecedor_event.dart';
import 'package:sgc/app/data/blocs/fornecedor/fornecedor_state.dart';
import 'package:sgc/app/models/fornecedor_model.dart';

import '../../repositories/fornecedor.dart';

class FornecedorBloc {
  final _repository = Fornecedor();

  final StreamController<FornecedorEvent> _inputController =
      StreamController<FornecedorEvent>();
  final StreamController<FornecedorState> _outputController =
      StreamController<FornecedorState>();

  Sink<FornecedorEvent> get inputFornecedor => _inputController.sink;
  Stream<FornecedorState> get outputFornecedor => _outputController.stream;

  FornecedorBloc() {
    _inputController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(FornecedorEvent event) async {
    var fornecedor = FornecedorModel();

    _outputController.add(FornecedorLoadingState());

    if (event is GetFornecedor) {
      //fornecedor = await _repository.fetchFornecedor(event.idFornecedor);
    }

    _outputController.add(
      FornecedorLoadedState(
        fornecedor: fornecedor,
      ),
    );
  }
}
