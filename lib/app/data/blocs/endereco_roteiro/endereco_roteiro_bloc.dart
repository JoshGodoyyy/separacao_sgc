import 'dart:async';

import 'package:sgc/app/data/blocs/endereco_roteiro/endereco_roteiro_event.dart';
import 'package:sgc/app/data/blocs/endereco_roteiro/endereco_roteiro_state.dart';
import 'package:sgc/app/data/repositories/endereco_roteiro_entrega.dart';

class EnderecoRoteiroBloc {
  final _repository = EnderecoRoteiroEntrega();

  final StreamController<EnderecoRoteiroEvent> _inputEnderecoController =
      StreamController<EnderecoRoteiroEvent>();
  final StreamController<EnderecoRoteiroState> _outputEnderecoController =
      StreamController<EnderecoRoteiroState>();

  Sink<EnderecoRoteiroEvent> get inputRoteiroEntregaController =>
      _inputEnderecoController.sink;
  Stream<EnderecoRoteiroState> get outputRoteiroEntregaController =>
      _outputEnderecoController.stream;

  EnderecoRoteiroBloc() {
    _inputEnderecoController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(EnderecoRoteiroEvent event) async {
    List enderecos = [];

    _outputEnderecoController.add(EnderecoRoteiroLoadingState());

    if (event is GetEnderecosRoteiro) {
      enderecos = await _repository.fetchEnderecosRoteiro(event.idRoteiro);
    } else if (event is AtualizarPosicao) {
      enderecos = await _repository.atualizarOrdem(
        event.idRoteiro,
        event.enderecos,
      );
    } else if (event is EntregarPedido) {
      enderecos = await _repository.entregarPedido(
        event.idRoteiro,
        event.cep,
        event.numero,
        event.idSituacao,
        event.idCliente,
      );
    }

    _outputEnderecoController
        .add(EnderecoRoteiroLoadedState(enderecos: enderecos));
  }
}
