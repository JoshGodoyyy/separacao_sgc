import 'dart:async';

import 'package:sgc/app/data/blocs/produto/produto_event.dart';
import 'package:sgc/app/data/blocs/produto/produto_state.dart';
import 'package:sgc/app/data/repositories/produto.dart';

class ProdutoBloc {
  final _repository = Produto();

  final StreamController<ProdutoEvent> _inputProdutoController =
      StreamController<ProdutoEvent>();
  final StreamController<ProdutoState> _outputProdutoController =
      StreamController<ProdutoState>();

  Sink<ProdutoEvent> get inputProdutoController => _inputProdutoController.sink;
  Stream<ProdutoState> get outputProdutoController =>
      _outputProdutoController.stream;

  ProdutoBloc() {
    _inputProdutoController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(ProdutoEvent event) async {
    List<dynamic> produtos = [];

    _outputProdutoController.add(ProdutoLoadingState());

    if (event is GetProdutos) {
      produtos = await _repository.fetchProdutos(
        event.perfis,
        event.acessorios,
        event.chapas,
        event.vidros,
        event.kits,
        event.idPedido,
      );
    } else if (event is UpdateSeparacao) {
      produtos = await _repository.updateProduto(
        event.idProduto,
        event.separado,
        event.idPedido,
        event.perfis,
        event.acessorios,
        event.chapas,
        event.vidros,
        event.kits,
      );
    } else if (event is UpdateEmbalagem) {
      produtos = await _repository.updateEmbalado(
        event.idProduto,
        event.embalado,
        event.idPedido,
        event.perfis,
        event.acessorios,
        event.chapas,
        event.vidros,
        event.kits,
      );
    } else if (event is UpdateConferencia) {
      produtos = await _repository.updateConferido(
        event.idProduto,
        event.conferido,
        event.idPedido,
        event.perfis,
        event.acessorios,
        event.chapas,
        event.vidros,
        event.kits,
      );
    }

    _outputProdutoController.add(ProdutoLoadedState(produtos: produtos));
  }
}
