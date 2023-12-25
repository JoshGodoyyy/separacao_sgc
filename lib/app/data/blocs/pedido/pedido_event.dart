import '../../../models/pedido_model.dart';

abstract class PedidoEvent {}

class GetPedidosSituacao extends PedidoEvent {
  final int idSituacao;

  GetPedidosSituacao({required this.idSituacao});
}

class PostPedido extends PedidoEvent {
  final PedidoModel pedido;

  PostPedido({required this.pedido});
}

class DeletePedido extends PedidoEvent {
  final PedidoModel pedido;

  DeletePedido({required this.pedido});
}
