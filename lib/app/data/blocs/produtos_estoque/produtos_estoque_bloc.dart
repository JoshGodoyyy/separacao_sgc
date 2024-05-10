import 'dart:async';

import 'package:sgc/app/data/repositories/produto_estoque.dart';

import 'produtos_estoque_event.dart';
import 'produtos_estoque_state.dart';

class ProdutosEstoqueBloc {
  final _repository = ProdutoEstoque();

  final StreamController<ProdutosEstoqueEvent> _inputProdutosEstoqueController =
      StreamController<ProdutosEstoqueEvent>();
  final StreamController<ProdutosEstoqueState>
      _outputProdutosEstoqueController =
      StreamController<ProdutosEstoqueState>();

  Sink<ProdutosEstoqueEvent> get inputProdutosEstoqueController =>
      _inputProdutosEstoqueController.sink;
  Stream<ProdutosEstoqueState> get outputProdutosEstoqueController =>
      _outputProdutosEstoqueController.stream;

  ProdutosEstoqueBloc() {
    _inputProdutosEstoqueController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(ProdutosEstoqueEvent event) async {
    List<dynamic> produtosEstoque = [];

    _outputProdutosEstoqueController.add(
      ProdutosEstoqueLoadingState(),
    );

    if (event is GetProdutosEstoque) {
      produtosEstoque = await _repository.fetchEstoque();
    }

    _outputProdutosEstoqueController.add(
      ProdutosEstoqueLoadedState(produtosEstoque: produtosEstoque),
    );
  }
}
