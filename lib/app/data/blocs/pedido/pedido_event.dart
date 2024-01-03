import '../../../models/pedido_model.dart';

abstract class PedidoEvent {}

class GetPedidosSituacao extends PedidoEvent {
  final int idSituacao;

  GetPedidosSituacao({required this.idSituacao});
}

class SearchPedido extends PedidoEvent {
  final int idSituacao;
  final int idPedido;

  SearchPedido({required this.idSituacao, required this.idPedido});
}

class PostPedido extends PedidoEvent {
  final PedidoModel pedido;

  PostPedido({required this.pedido});
}

class DeletePedido extends PedidoEvent {
  final PedidoModel pedido;

  DeletePedido({required this.pedido});
}
