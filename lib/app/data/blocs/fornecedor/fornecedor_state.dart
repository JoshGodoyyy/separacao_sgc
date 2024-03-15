import 'package:sgc/app/models/fornecedor_model.dart';

abstract class FornecedorState {
  final FornecedorModel? fornecedor;

  FornecedorState({required this.fornecedor});
}

class FornecedorInitialState extends FornecedorState {
  FornecedorInitialState() : super(fornecedor: null);
}

class FornecedorLoadingState extends FornecedorState {
  FornecedorLoadingState() : super(fornecedor: null);
}

class FornecedorLoadedState extends FornecedorState {
  FornecedorLoadedState({required super.fornecedor});
}

class FornecedorErrorState extends FornecedorState {
  final String exception;

  FornecedorErrorState({required this.exception}) : super(fornecedor: null);
}
