import 'package:sgc/app/models/pedido_model.dart';

abstract class PedidoEvent {}

class GetPedidosSituacao extends PedidoEvent {
  final int idSituacao;

  GetPedidosSituacao({required this.idSituacao});
}

class PostPedido extends PedidoEvent {
  final Pedido pedido;

  PostPedido({required this.pedido});
}

class DeletePedido extends PedidoEvent {
  final Pedido pedido;

  DeletePedido({required this.pedido});
}
