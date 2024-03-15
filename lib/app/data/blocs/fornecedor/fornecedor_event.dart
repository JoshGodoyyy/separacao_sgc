abstract class FornecedorEvent {}

class GetFornecedor extends FornecedorEvent {
  final int idFornecedor;

  GetFornecedor({required this.idFornecedor});
}
